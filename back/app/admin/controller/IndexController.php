<?php
namespace app\admin\controller;
use vae\controller\AdminCheckLogin;

class IndexController extends AdminCheckLogin
{
    public function index()
    {
        return view();
    }
}
