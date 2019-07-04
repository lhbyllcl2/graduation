<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/5/10
 * Time: 17:57
 */

namespace app\admin\controller;

use vae\controller\AdminCheckAuth;

/**
 * 店铺管理
 * Class ShopController
 * @package app\admin\controller
 */
class ShopController extends AdminCheckAuth
{
    public function index()
    {
        return view();
    }

    public function getOrderList()
    {

    }

    public function add()
    {
        return view();
    }
}