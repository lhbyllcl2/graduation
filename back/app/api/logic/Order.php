<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/5/5
 * Time: 9:23
 */

namespace app\api\logic;


use think\Db;

class Order
{
    /**
     * 确认下单
     * @param $param
     * @param $uid
     * @return array|int
     */
    public static function confirm($param, $uid)
    {
        //todo 各个参数的验证
        $orderModel = db('order');
        $entities = $param['entities'][0];
        $total = 0;
        $bookOrder = [];
        foreach ($entities as $val) {
            if (!$val['quantity']) {
                continue;
            }
            $bookOrder[] = [
                'order_id'    => '',
                'cookbook_id' => $val['id'],
                'name'        => $val['name'],
                'price'       => $val['price'],
                'num'         => $val['quantity'],
            ];
            $total += round($val['price'] * $val['quantity'], 2);
        }
        $addData = [
            'order_sn'     => get_order_sn(),
            'member_id'    => $uid,
            'total_prices' => $total + 4,
            'leave_words'  => $param['description'],
            'address_id'   => $param['address_id']
        ];
        Db::startTrans();
        try {
            $order_id = $orderModel->insert($addData, false, true);
            array_walk($bookOrder, function (&$item) use (&$order_id) {
                $item['order_id'] = $order_id;
            });
            db('order_book')->insertAll($bookOrder);
            $where = [
                'member_id' => $uid,
            ];
            db('shop_cart')->where($where)->delete();
            // 提交事务
            Db::commit();
            return [
                'order_id' => $order_id
            ];
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            return 2002;
        }
    }

    /***
     * 订单支付确认
     * @param $order_id
     * @param $uid
     * @return array
     */
    public static function queryOrder($order_id, $uid)
    {
        return [];
    }

    /**
     * 确认支付
     * @param $order_id
     * @param $uid
     * @return bool
     */
    public static function confrimPay($order_id, $uid)
    {
        $where = [
            'order_id'  => $order_id,
            'member_id' => $uid,
        ];
        db('order')->where($where)->setField([
            'status'   => 1,
            'pay_time' => date('Y-m-d H:i:s'),
        ]);
        return true;
    }

    /**
     * 订单列表
     * @param $uid
     * @return array
     */
    public static function orderLists($uid)
    {
        $order = db('order')->where('member_id', $uid)->select();
        if (!$order) {
            return [];
        }
        $order = collection($order)->toArray();
        $order_ids = array_column($order, 'order_id');
        $goods = db('order_book')->where('order_id', 'in', $order_ids)->select();
        if (!$goods) {
            return [];
        }
        $goods = collection($goods)->toArray();
        $goodsGroup = [];
        foreach ($goods as $val) {
            $order_id = $val['order_id'];
            $goodsGroup[$order_id][] = [
                'name'     => $val['name'],
                'price'    => $val['price'],
                'quantity' => $val['num'],
            ];
        }
        unset($val);
        $result = [];
        foreach ($order as &$value) {
            $group = [];
            if (array_key_exists($value['order_id'], $goodsGroup)) {
                $group = $goodsGroup[$value['order_id']];
            }
            switch ($value['status']) {
                case 1:
                    $title = '待发货';
                    break;
                case 2:
                    $title = '待收货';
                    break;
                case 3:
                    $title = '待评价';
                    break;
                case 4:
                    $title = '已完成';
                    break;
            }
            $result[] = [
                'order_sn'             => $value['order_sn'],
                'restaurant_name'      => '碳在烧.烤肉',
                "restaurant_image_url" => "https://lhy01.oss-cn-beijing.aliyuncs.com/graduate/foods.jpg",
                "formatted_created_at" => date('Y-m-d H:i', strtotime($value['create_time'])),
                "total_amount"         => $value['total_prices'],
                "total_quantity"       => 3,
                "deliver_time"         => '2018-11',
                "status"               => $value['status'],
                "status_ps"            => $title,
                "is_new_pay"           => 1,
                "is_deletable"         => 1,
                "basket"               => [
                    "packing_fee" => [
                        "price"       => 1,
                        "quantity"    => 1,
                        "name"        => "餐盒",
                        "category_id" => 1
                    ],
                    "group"       => [$group],
                    "deliver_fee" => [
                        "quantity"    => 1,
                        "price"       => 4,
                        "name"        => "配送费",
                        "category_id" => 2
                    ],
                ]
            ];
        }
        unset($value);
        return $result;
    }

    /***
     * 订单详情
     * @param $order_sn
     * @param $uid
     * @return array
     */
    public static function orderDetails($order_sn, $uid)
    {
        $where = [
            'member_id' => $uid,
            'order_sn'  => $order_sn,
        ];
        $order = db('order')->where($where)->find();
        if (!$order) {
            return [];
        }
        $goods = db('order_book')->where('order_id', $order['order_id'])->select();
        if (!$goods) {
            return [];
        }
        $goodsGroup = [];
        foreach ($goods as $val) {
            $order_id = $val['order_id'];
            $goodsGroup[$order_id][] = [
                'name'     => $val['name'],
                'price'    => $val['price'],
                'quantity' => $val['num'],
            ];
        }
        unset($val);
        //获取地址
        $address_id = $order['address_id'];
        $addressInfo = db('member_address')->where('address_id', $address_id)->find();
        $title = '待支付';
        switch ($order['status']) {
            case 1:
                $title = '待发货';
                break;
            case 2:
                $title = '待收货';
                break;
            case 3:
                $title = '待评价';
                break;
            case 4:
                $title = '已完成';
                break;
        }
        $result = [
            'id'                   => $order['order_sn'],
            'restaurant_name'      => '碳在烧.烤肉',
            "restaurant_image_url" => "https://lhy01.oss-cn-beijing.aliyuncs.com/graduate/foods.jpg",
            "formatted_created_at" => date('Y-m-d H:i', strtotime($order['create_time'])),
            "total_amount"         => $order['total_prices'],
            "total_quantity"       => count($goodsGroup[$order['order_id']]),
            "deliver_time"         => date('Y-m-d H:i', strtotime($order['create_time']) + 3200),
            "consignee"            => mb_substr($addressInfo['name'], 0, 1) . ($addressInfo['sex'] == 1 ? '先生' : '女士'),
            "phone"                => $addressInfo['phone'],
            "address"              => $addressInfo['address_detail'],
            "timeline_node"        => [
                'description' => '1111'
            ],
            "status_bar"           => [
                "color"      => "#f00",
                "image_type" => "",
                "sub_title"  => "15分钟内支付",
                "title"      => $title
            ],
            "is_new_pay"           => 1,
            "is_deletable"         => 1,
            "basket"               => [
                "packing_fee" => [
                    "price"       => 1,
                    "quantity"    => 1,
                    "name"        => "餐盒",
                    "category_id" => 1
                ],
                "group"       => [$goodsGroup[$order['order_id']]],
                "deliver_fee" => [
                    "quantity"    => 1,
                    "price"       => 4,
                    "name"        => "配送费",
                    "category_id" => 2
                ],
            ]
        ];
        return $result;
    }

    /**
     * 评论处理
     * @param $uid
     * @param $contents
     * @return bool
     */
    public static function evaluate($uid, $contents)
    {
        $order_sn = $contents['order_sn'];
        $orderModel = db('order');
        $orderInfo = $orderModel->where('order_sn', $order_sn)->find();
        if (!$orderInfo) {
            return 2003;
        }
        if ($orderInfo['status'] != 3) {
            return 2004;//未到评价节点
        }
        $addData = [
            'order_id'  => $orderInfo['order_id'],
            'contents'  => $contents['contents'],
            'item1'     => $contents['rating1'],
            'item2'     => $contents['rating2'],
            'average'   => round(($contents['rating1'] + $contents['rating2']) / 2, 2),
            'member_id' => $uid,
        ];
        Db::startTrans();
        try {
            db('order_comment')->insert($addData);
            $orderModel->where('order_sn', $order_sn)->setField('status', 4);
            Db::commit();
            return true;
        } catch (\Exception $E) {
            Db::rollback();
            return 2005;
        }
    }
}