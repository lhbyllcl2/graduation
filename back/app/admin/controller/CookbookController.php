<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/22
 * Time: 10:04
 */

namespace app\admin\controller;

use app\common\lib\AliYunOss;
use vae\controller\AdminCheckAuth;


/**
 * 菜谱管理
 * Class CookbookController
 * @package app\admin\controller
 */
class CookbookController extends AdminCheckAuth
{
    public function index()
    {
        return view();
    }

    public function getContentList()
    {
        $param = vae_get_param();
        $where = [
            'a.is_delete' => 0
        ];
        if (!empty($param['keywords'])) {
            $where['a.cookbook_id|a.cookbook_name|w.item_name'] = ['like', '%' . $param['keywords'] . '%'];
        }
        if (!empty($param['article_cate_id'])) {
            $where['a.item_id'] = $param['item_id'];
        }
        $rows = empty($param['limit']) ? \think\Config::get('paginate.list_rows') : $param['limit'];
        $content = model('Cookbook')
            ->field('*,w.item_id as cate_id,a.cookbook_id as id,w.item_name as cate_title,a.cookbook_name as title')
            ->alias('a')
            ->join('cookbook_item w', 'a.item_id = w.item_id')
            ->order('a.create_time desc')
            ->where($where)
            ->paginate($rows, false, ['query' => $param]);

        return vae_assign_table(0, '', $content);
    }

    public function add()
    {
        return view();
    }

    /**
     * 添加菜谱
     */
    public function addSubmit()
    {
        if ($this->request->isPost()) {
            $param = vae_get_param();
            model('Cookbook')->strict(false)->field(true)->insert($param);
            return vae_assign();
        }
    }

    public function edit()
    {
        $id = input('id');
        $info = model('Cookbook')->where('cookbook_id', $id)->find();
        return view('edit', [
            'data' => $info
        ]);
    }

    /***
     * 提交编辑
     */
    public function editSubmit()
    {
        $cookbook_id = input('cookbook_id');
        model('Cookbook')->allowField(true)->save(input(), ['cookbook_id' => $cookbook_id]);
        $this->success('更新成功');
    }

    public function delete()
    {
        $id = input('id');
        model('Cookbook')->where('cookbook_id', $id)->setField('is_delete', 1);
        $this->success('删除成功');
    }

    public function change()
    {
        $id = input('id');
        $status = model('Cookbook')->where('cookbook_id', $id)->value('status');
        if ($status) {
            $newStatus = 0;
        } else {
            $newStatus = 1;
        }
        model('Cookbook')->where('cookbook_id', $id)->setField('status', $newStatus);
        $this->success('操作成功');
    }

}