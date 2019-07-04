<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/5/9
 * Time: 17:55
 */

namespace app\admin\controller;


use vae\controller\AdminCheckAuth;

/***
 * 会员管理
 * Class MemberController
 * @package app\admin\controller
 */
class MemberController extends AdminCheckAuth
{
    public function index()
    {
        return view();
    }

    public function getMemberList()
    {
        $param = input();
        $where = array();
        if (!empty($param['keywords'])) {
            $where['member_id|login_name|nickname'] = ['like', '%' . $param['keywords'] . '%'];
        }
        $rows = empty($param['limit']) ? config('paginate.list_rows') : $param['limit'];
        $slide = db('member')
            ->order('create_time asc')
            ->where($where)
            ->paginate($rows, false, ['query' => $param]);
        return vae_assign_table(0, '', $slide);
    }

    /***
     * 禁用和启用
     */
    public function tiggle()
    {
        $member_id = input('member_id');
        $info = db('member')->where('member_id', $member_id)->find();
        $status = $info['status'];
        $newStatus = $status == 0 ? 1 : 0;
        db('member')->where('member_id', $member_id)->setField('status', $newStatus);
        $this->success();
    }
}