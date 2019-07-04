<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/11
 * Time: 11:43
 */

namespace app\api\controller;


use app\common\controller\ApiBaseController;

class ShopController extends ApiBaseController
{
    protected $authToken = false;

    /***
     * 商铺详情
     */
    public function restaurant()
    {
        $data = <<<DATA
        {
        "name": "碳在烧.烤肉（银泰城店）", 
        "address": "四川省成都市高新区天府四街", 
        "id": 1, 
        "latitude": 23.12497, 
        "longitude": 113.26308, 
        "location": [
            113.26308, 
            23.12497
        ], 
        "phone": "13437850035", 
        "category": "快餐便当/简餐", 
        "supports": [
            {
                "description": "已加入“外卖保”计划，食品安全有保障", 
                "icon_color": "999999", 
                "icon_name": "保", 
                "id": 7, 
                "name": "外卖保", 
                "_id": "5a5859a19c2bc57d52df30b3"
            }, 
            {
                "description": "准时必达，超时秒赔", 
                "icon_color": "57A9FF", 
                "icon_name": "准", 
                "id": 9, 
                "name": "准时达", 
                "_id": "5a5859a19c2bc57d52df30b2"
            }, 
            {
                "description": "该商家支持开发票，请在下单时填写好发票抬头", 
                "icon_color": "999999", 
                "icon_name": "票", 
                "id": 4, 
                "name": "开发票", 
                "_id": "5a5859a19c2bc57d52df30b1"
            }
        ], 
        "status": 1, 
        "recent_order_num": 106, 
        "rating_count": 961, 
        "rating": 4.7, 
        "promotion_info": "欢迎光临，用餐高峰请提前下单，谢谢", 
        "piecewise_agent_fee": {
            "tips": "配送费约¥4"
        }, 
        "opening_hours": [
            "8:30/20:30"
        ], 
        "license": {
            "catering_service_license_image": "160e91e17fa2164.png", 
            "business_license_image": "160e91e0a9f2163.png"
        }, 
        "is_new": true, 
        "is_premium": true, 
        "image_path": "https://lhy01.oss-cn-beijing.aliyuncs.com/graduate/foods.jpg", 
        "identification": {
            "registered_number": "", 
            "registered_address": "", 
            "operation_period": "", 
            "licenses_scope": "", 
            "licenses_number": "", 
            "licenses_date": "", 
            "legal_person": "", 
            "identificate_date": null, 
            "identificate_agency": "", 
            "company_name": ""
        }, 
        "float_minimum_order_amount": 20, 
        "float_delivery_fee": 4, 
        "distance": "", 
        "order_lead_time": "20", 
        "description": "sad", 
        "delivery_mode": {
            "color": "57A9FF", 
            "id": 1, 
            "is_solid": true, 
            "text": "蜂鸟专送"
        }, 
        "activities": [ ]
    }
DATA;
        $this->responseSuccess('', json_decode($data, true));
    }

    /***
     * 获取商家的菜单
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function menu()
    {
        $item = model('CookbookItem')->field('item_id,item_name,description')->where('is_delete', 0)->select();
        if (!$item) {
            $this->responseSuccess('', []);
        }
        $items = collection($item)->toArray();
        $items = array_column($items, null, 'item_id');
        //查询菜单
        $where = [
            'is_delete' => 0,
            'status'    => 1,
        ];
        $menu = model('Cookbook')
            ->field('cookbook_id,cookbook_name,description,thumb,item_id,price,sales_volume,sales_promotion,create_time')
            ->where($where)
            ->order('create_time desc')
            ->select();
        if (!$menu) {
            $this->responseSuccess('', []);
        }
        $menu = collection($menu)->toArray();
        $menus = [];
        $item_id = 100;
        foreach ($menu as &$val) {
            $activity = false;//判断有无促销信息
            if ($val['sales_promotion']) {
                $activity = [
                    "image_text"       => $val['sales_promotion'],
                    "icon_color"       => "f07373",
                    "image_text_color" => "f1884f"
                ];
            }
            //判断是否为新品 默认为10天内的为新品
            $attributes = [];
            if (time() - strtotime($val['create_time']) < 10 * 86400) {
                $attributes = [
                    [
                        "icon_name"  => "新",
                        "icon_color" => "3190E8"
                    ]
                ];
            }

            $menus[] = [
                "tips"           => sprintf('%d评价 售%d份', 100, $val['sales_volume']),
                "item_id"        => $item_id,
                "category_id"    => $val['item_id'],
                "restaurant_id"  => 1,
                "activity"       => $activity,
                "image_path"     => $val['thumb'],
                "name"           => $val['cookbook_name'],
                "specfoods"      => [
                    [
                        "specs_name"        => "默认",
                        "name"              => $val['cookbook_name'],
                        "item_id"           => $item_id,
                        "sku_id"            => 5871,
                        "food_id"           => $val['cookbook_id'],
                        "restaurant_id"     => 1,
                        "specs"             => [

                        ],
                        "stock"             => 99999,
                        "checkout_mode"     => 1,
                        "is_essential"      => false,
                        "recent_popularity" => 293,
                        "sold_out"          => false,
                        "price"             => $val['price'],
                        "promotion_stock"   => -1,
                        "recent_rating"     => 1,
                        "packing_fee"       => 1,
                        "pinyin_name"       => "",
                        "original_price"    => 0
                    ]
                ],
                "satisfy_rate"   => mt_rand(70, 99),
                "satisfy_count"  => 222,
                "attributes"     => $attributes,
                "is_essential"   => false,
                "server_utc"     => $val['create_time'],
                "specifications" => [],
                "rating_count"   => mt_rand(0, 200),
                "month_sales"    => mt_rand(0, 1000),
                "description"    => $val['description'],
                "attrs"          => [],
                "display_times"  => [],
                "pinyin_name"    => "",
                "is_featured"    => 0,
                "rating"         => sprintf('%d.%d', mt_rand(3, 4), mt_rand(2, 9))
            ];
            $item_id++;
        }
        unset($val);
        $group = [];
        foreach ($menus as &$val) {
            $group[$val['category_id']][] = $val;
        }
        unset($val);
        $result = [];
        foreach ($items as $key => &$val) {
            $foods = [];
            if (array_key_exists($key, $group)) {
                $foods = $group[$key];
            }
            $result[] = [
                'name'          => $val['item_name'],
                'description'   => $val['description'],
                'restaurant_id' => 1,
                "id"            => $val['item_id'],
                "type"          => 1,
                "icon_url"      => "",
                "is_selected"   => true,
                'foods'         => $foods
            ];
        }
        unset($val);
        $this->responseSuccess('', $result);
    }

    /**
     * 获取评价信息
     */
    public function restaurants()
    {
        $res = db('order_comment')
            ->alias('a')
            ->field('a.*,b.login_name')
            ->join('vae_member b', 'a.member_id=b.member_id')
            ->select();
        $result = [];
        foreach ($res as $val) {
            $result[] = [
                'rating_star'     => $val['average'],
                'rating_text'     => $val['contents'],
                'time_spent_desc' => '',
                'username'        => substr_replace($val['login_name'], '****', 3, 4),
                'item_ratings'    => [],
                'tags'            => [],
                "avatar"          => "",
                "highlights"      => [],
                "reply_contents"  => $val['reply_contents'],
                "rated_at"        => date('Y-m-d H:i', strtotime($val['create_time'])),
            ];
        }
        $this->responseSuccess('', $result);
    }

    public function scores()
    {
        $str = '
        {
            "compare_rating":0.76,
            "deliver_time":40,
            "food_score":4.76378,
            "order_rating_amount":473,
            "overall_score":4.72,
            "service_score":4.69
        }
        ';
        $this->responseSuccess('ok', json_decode($str));
    }

    public function tags()
    {
        $data = <<<DATA

[
    {
        "name":"全部",
        "_id":"5a22f885ec81ce77ee8449a3",
        "unsatisfied":false,
        "count":473
    },
    {
        "name":"满意",
        "_id":"5a22f885ec81ce77ee8449a2",
        "unsatisfied":false,
        "count":453
    },
    {
        "name":"不满意",
        "_id":"5a22f885ec81ce77ee8449a1",
        "unsatisfied":true,
        "count":20
    },
    {
        "name":"有图",
        "_id":"5a22f885ec81ce77ee8449a0",
        "unsatisfied":false,
        "count":2
    },
    {
        "name":"味道好",
        "_id":"5a22f885ec81ce77ee84499f",
        "unsatisfied":false,
        "count":47
    },
    {
        "name":"送货快",
        "_id":"5a22f885ec81ce77ee84499e",
        "unsatisfied":false,
        "count":32
    },
    {
        "name":"分量足",
        "_id":"5a22f885ec81ce77ee84499d",
        "unsatisfied":false,
        "count":18
    },
    {
        "name":"包装精美",
        "_id":"5a22f885ec81ce77ee84499c",
        "unsatisfied":false,
        "count":15
    },
    {
        "name":"干净卫生",
        "_id":"5a22f885ec81ce77ee84499b",
        "unsatisfied":false,
        "count":15
    },
    {
        "name":"食材新鲜",
        "_id":"5a22f885ec81ce77ee84499a",
        "unsatisfied":false,
        "count":15
    },
    {
        "name":"服务不错",
        "_id":"5a22f885ec81ce77ee844999",
        "unsatisfied":false,
        "count":11
    }
]

DATA;
        $this->responseSuccess('', json_decode($data));
    }
}