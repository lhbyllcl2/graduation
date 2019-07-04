<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/25
 * Time: 8:59
 */

namespace app\api\controller;


use app\api\logic\Order;
use app\common\controller\ApiBaseController;
use WebGeeker\Validation\Validation;

class OrderController extends ApiBaseController
{
    /**
     * 加入购物车
     */
    public function checkout()
    {
        $param = input();
        array_key_exists('entities', $param) || $this->responseError(1002, '', '参数错误');
        $cartLists = $param['entities'][0];
        //todo 价格验证等
        $addData = [];
        $payTotal = 0;
        $deliverAmount = 4;
        foreach ($cartLists as &$val) {
            if (!$val['quantity']) {
                continue;
            }
            $addData[] = [
                'member_id'     => $this->uid,
                'cookbook_id'   => $val['id'],
                'cookbook_name' => $val['name'],
                'price'         => $val['price'],
                'count'         => $val['quantity'],
            ];
            $payTotal += $val['price'] * $val['quantity'];
        }
        unset($val);
        $model = db('shop_cart');
        $isExist = $model->where('member_id', $this->uid)->count();
        if ($isExist) {
            $model->where('member_id', $this->uid)->delete();
        }
        if ($addData) {
            $model->insertAll($addData);
        }
        $result = [
            'shop_id'             => 1,
            'delivery_reach_time' => date('H:i', strtotime('+1 hour')), //送货到达时间
            'is_support_ninja'    => 1,
            'is_support_coupon'   => false,
            'payments'            => [//付款说明
                [
                    "description"       => "（商家不支持货到付款）",
                    "disabled_reason"   => "商家仅支持在线支付",
                    "id"                => 2,
                    "name"              => "货到付款",
                    "is_online_payment" => false
                ],
                [
                    "description"       => "（商家仅支持在线支付）",
                    "disabled_reason"   => "",
                    "id"                => 1,
                    "name"              => "在线支付",
                    "is_online_payment" => true
                ]
            ],
            "invoice"             => [
                "status_text"  => "不需要开发票",
                "is_available" => true
            ],
            "cart"                => [
                'restaurant_info' => [
                    'name'       => '碳在烧.烤肉（银泰城店）',
                    'image_path' => 'https://lhy01.oss-cn-beijing.aliyuncs.com/graduate/foods.jpg'
                ],
                'groups'          => [$cartLists],
                "extra"           => [//附加说明
                    [
                        "name"        => "餐盒",
                        "type"        => 0,
                        "quantity"    => 1,
                        "price"       => 0,
                        "description" => ""

                    ]
                ],
                "deliver_amount"  => $deliverAmount,//配送费,
                "total"           => round($payTotal + $deliverAmount, 2)
            ]
        ];
        $this->responseSuccess('', $result);
    }

    /**
     * 订单备注选项
     */
    public function remarks()
    {
        $result["remarks"] = [
            [
                "不要辣",
                "少点辣",
                "多点辣"
            ],
            [
                "不要香菜"
            ],
            [
                "不要洋葱"
            ],
            [
                "多点醋"
            ],
            [
                "多点葱"
            ],
            [
                "去冰",
                "少冰"
            ]
        ];
        $this->responseSuccess('', $result);
    }

    /***
     * 确认下单
     */
    public function confirm()
    {
        $param = input();
        try {
            Validation::validate($param, [
                "cart_id"     => "Required",
                "address_id"  => "Required",
                "description" => "Required",
                "entities"    => "Required"
            ]);
            $res = Order::confirm($param, $this->uid);
            is_array($res) || $this->responseError($res);
            $this->responseSuccess('', $res);
        } catch (\Exception $e) {
            $this->responseError(1001, '', $e->getMessage());
        }
    }

    /***
     * 订单支付确认
     */
    public function queryOrder()
    {
        $param = input();
        try {
            Validation::validate($param, [
                "order_id" => "Required",
            ]);
            $res = Order::queryOrder($param['order_id'], $this->uid);
            is_array($res) || $this->responseError($res);
            $this->responseSuccess($res);
        } catch (\Exception $e) {
            $this->responseError(1001, '', $e->getMessage());
        }
    }

    /**
     * 确认付款
     */
    public function confrimPay()
    {
        $param = input();
        try {
            Validation::validate($param, [
                "order_id" => "Required",
            ]);
            $res = Order::confrimPay($param['order_id'], $this->uid);
            $res || $this->responseError($res);
            $this->responseSuccess($res);
        } catch (\Exception $e) {
            $this->responseError(1001, '', $e->getMessage());
        }
    }

    /**
     * 获取订单列表
     */
    public function orderLists()
    {
        $offset = input('offset');
        $res = Order::orderLists($this->uid);
        $this->responseSuccess('', $res);
    }

    /**
     * 订单详情
     */
    public function orderDetails()
    {
        $order_sn = input('order_id');
        $res = Order::orderDetails($order_sn, $this->uid);
        $this->responseSuccess('', $res);
    }

    /***
     * 订单评价
     */
    public function evaluate()
    {
        $param = input();
        try {
            Validation::validate($param, [
                "order_sn" => "Required",
                "rating1"  => "Required",
                "rating2"  => "Required",
                "contents" => "Required",
            ]);
            $res = Order::evaluate($this->uid, $param);
            $res || $this->responseError($res);
            $this->responseSuccess($res);
        } catch (\Exception $e) {
            $this->responseError(1001, '', $e->getMessage());
        }
    }
}