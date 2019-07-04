<?php

return [
    'msite/food/type'             => 'api/Index/msiteFoodTypes',//获取菜品，
    'msite/shop/lists'            => 'api/Index/shoplist',//获取商家列表，
    'shopping/details'            => 'api/Shop/restaurant',//店铺详情
    'shopping/menu'               => 'api/Shop/menu',//店铺菜单
    'shopping/comment/lists'      => 'api/Shop/restaurants',//评论列表
    'shopping/comment/scores'     => 'api/Shop/scores',//评论分数
    'shopping/comment/tags'       => 'api/Shop/tags',//评论标签
    'shopping/carts/checkout'     => 'api/Order/checkout',//加入购物车
    'shopping/order/confirm'      => 'api/Order/confirm',//下单
    'shopping/order/queryOrder'   => 'api/Order/queryOrder',//确认订单
    'shopping/order/remarks'      => 'api/Order/remarks',//下单时的备注
    'shopping/order/confrimPay'   => 'api/Order/confrimPay',//确认支付
    'shopping/order/orderLists'   => 'api/Order/orderLists',//订单列表
    'shopping/order/orderDetails' => 'api/Order/orderDetails',//订单详情
    'shopping/order/evaluate'     => 'api/Order/evaluate',//订单评价
    'api/user/get_user'           => 'api/User/getUser',//获取用户信息
    'user/verify_code/send'       => 'api/User/sendVerifyCode',//发送验证码
    'user/login/app_mobile'       => 'api/User/login',//登录
    'user/address/lists'          => 'api/User/addressesLists',//用户地址
    'user/address/add'            => 'api/User/addAddress',//添加地址
    'address/search/pois'         => 'api/Index/pois',//地址关键字搜索
];
