<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/5/9
 * Time: 17:29
 */

namespace app\admin\controller;

use vae\controller\AdminCheckAuth;

/***
 * 订单管理
 * Class OrderController
 * @package app\admin\controller
 */
class OrderController extends AdminCheckAuth
{
    public function index()
    {
        return view();
    }

    /**
     * 获取订单
     */
    public function getOrderList()
    {
        $param = input();
        $where = array();
        if (!empty($param['keywords'])) {
            $where['order_id|order_sn|name|phone'] = ['like', '%' . $param['keywords'] . '%'];
        }
        $rows = empty($param['limit']) ? config('paginate.list_rows') : $param['limit'];
        $data = db('order')
            ->alias('a')
            ->join('vae_member_address b', 'a.address_id=b.address_id')
            ->order('a.create_time desc')
            ->where($where)
            ->paginate($rows, false, ['query' => $param]);
        if ($data) {
            $lists = $data->toArray()['data'];
            $order_ids = array_column($lists, 'order_id');
            $orderBook = db('order_book')
                ->field('count(1) order_num,order_id')
                ->where('order_id', 'in', $order_ids)
                ->group('order_id')
                ->select();
            $orderBook = array_column(collection($orderBook)->toArray(), 'order_num', 'order_id');
            $data->each(function (&$item) use (&$orderBook) {
                $item['order_num'] = array_key_exists($item['order_id'], $orderBook) ? $orderBook[$item['order_id']] : 0;
                $status_ps = '';
                switch ($item['status']) {
                    case 1:
                        $status_ps = '待发货';
                        break;
                    case 2:
                        $status_ps = '待收货';
                        break;
                    case 3:
                        $status_ps = '待评价';
                        break;
                    case 4:
                        $status_ps = '已完成';
                        break;
                }
                $item['status_ps'] = $status_ps;
                $item['freight'] = '4.00';
                $item['data_url'] = url('order/details', ['order_id' => $item['order_id']]);
                return $item;
            });
        }
        return vae_assign_table(0, '', $data);
    }

    /**
     * 订单详情
     */
    public function details()
    {
        $order_id = input('order_id');
        $orderInfo = db('order')
            ->alias('a')
            ->join('vae_member_address b', 'a.address_id=b.address_id')
            ->field('a.*,b.name,b.phone,b.address_detail,b.sex')
            ->where('order_id', $order_id)
            ->find();
        $goods = db('order_book')->where('order_id', $order_id)->select();
        return view('details', [
            'orderInfo' => $orderInfo,
            'goods'     => $goods,
        ]);
    }

    /**
     * 评价
     */
    public function evaluate()
    {
        $order_id = input('order_id');
        $comment = db('order_comment')->where('order_id', $order_id)->find();
        return view('evaluate', [
            'data' => $comment
        ]);
    }

    /**
     * 回复评价
     */
    public function evaluateSubmit()
    {
        $comment_id = input('comment_id');
        db('order_comment')->where('comment_id', $comment_id)->setField([
            'reply_contents' => input('reply_contents'),
            'reply_time'     => date('Y-m-d H:i:s'),
        ]);
        $this->success('成功');
    }
}