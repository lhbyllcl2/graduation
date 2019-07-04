<?php

namespace app\admin\validate;

use think\Validate;

class CookbookItem extends Validate
{
    protected $rule = [
        'item_name' => 'require|unique:cookbook_item',
        'pid'       => 'require',
        'item_id'   => 'require',
    ];

    protected $message = [
        'item_name.require' => '名称不能为空',
        'pid.require'       => '父级分类为必选',
        'item_name.unique'  => '同样的记录已经存在!',
        'item_id.require'   => '缺少更新条件',
    ];

    protected $scene = [
        'add'  => ['item_name', 'pid'],
        'edit' => ['item_id', 'item_name.unique'],
    ];
}