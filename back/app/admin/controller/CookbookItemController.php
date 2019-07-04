<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/22
 * Time: 9:58
 */

namespace app\admin\controller;


use vae\controller\AdminCheckAuth;

/**
 * 菜品分类管理
 * Class CookbookItemController
 * @package app\admin\controller
 */
class CookbookItemController extends AdminCheckAuth
{
    /**
     * 菜单分类列表
     */
    public function index()
    {
        return view();
    }

    /**
     * 获取分类列表
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getCateList()
    {
        $cate = model('CookbookItem')->where('is_delete', 0)->order('item_id asc')->select();
        return vae_assign(0, '', $cate);
    }

    public function add()
    {
        return view('', ['pid' => vae_get_param('pid')]);
    }

    public function addSubmit()
    {
        if ($this->request->isPost()) {
            $result = $this->validate(vae_get_param(), 'app\admin\validate\CookbookItem.add');
            if ($result !== true) {
                return vae_assign(0, $result);
            } else {
                model('CookbookItem')->field(true)->insert(vae_get_param());
                return vae_assign();
            }
        }
    }

    public function edit()
    {

    }

    public function editSubmit()
    {
        db('cookbook_item')->where('item_id', input('id'))->setField('item_name', input('name'));
        return $this->success();
    }

    public function delete()
    {
        db('cookbook_item')->where('item_id', input('id'))->setField('is_delete', 1);
        return $this->success('删除成功');
    }
}