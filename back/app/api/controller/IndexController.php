<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/10
 * Time: 14:42
 */

namespace app\api\controller;


use app\common\controller\ApiBaseController;
use \Curl\Curl;

class IndexController extends ApiBaseController
{
    protected $authTokenWhiteList = ['api.Index.msiteFoodTypes', 'api.Index.shoplist'];

    public function index()
    {
        $this->responseSuccess();
    }

    /***
     *获取分类
     */
    public function msiteFoodTypes()
    {
        $res = db('slide_info')->select();
        $result = [];
        foreach ($res as $val) {
            $result[] =
                [
                    'id'        => $val['id'],
                    'image_url' => $val['img'],
                    'title'     => $val['title'],
                ];
        }
        $this->responseSuccess('', $result);
    }

    public function shoplist()
    {
        $imgUrl = [
            'https://lhy01.oss-cn-beijing.aliyuncs.com/a1dc658ab957d2743fb0152caf1297dfa540ea81.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/1398a92a793016f5aae2dab5c16647c998072c11.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/cedd760e4480d17c29f4b45d2580e6c73e2a8a65.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/d8442c121a97f435ef7778265779efe27675a185.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/dd4ced770528d5e5feffafcbffe3d5037ea844ba.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/7fa2ef158e9da11f03a37c7e3922b753117988.jpg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/3e5fa74fe6ed3716e2396a4cf70abcc1352917.jpg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/5372a687a4546570e4db08fd1cd408fd1152881.jpg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/cedd760e4480d17c29f4b45d2580e6c73e2a8a65.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/d8442c121a97f435ef7778265779efe27675a185.jpeg',
            'https://lhy01.oss-cn-beijing.aliyuncs.com/7fa2ef158e9da11f03a37c7e3922b753117988.jpg',
        ];
        $name = ['碳在烧', '探鱼', '逗蛙', '花图缘', '重庆.矮板凳', '听香·花醉', '铜人李火锅', '自留田西北菜', '城门口老火锅', '四海一家', '川西涮烤自助火锅'];
        foreach (range(0, 6) as $val) {
            $result[] =
                [
                    'id'                         => $val,
                    'name'                       => $name[$val],
                    'image_path'                 => $imgUrl[mt_rand(0, count($imgUrl) - 1)],
                    'is_premium'                 => 1,
                    'supports'                   => [
                        [
                            "description" => "已加入“外卖保”计划，食品安全有保障",
                            "icon_color"  => "999999",
                            "icon_name"   => "保",
                            "id"          => 7,
                            "name"        => "外卖保",
                        ],
                        [
                            "description" => "准时必达，超时秒赔",
                            "icon_color"  => "57A9FF",
                            "icon_name"   => "准",
                            "id"          => 9,
                            "name"        => "准时达",

                        ],
                        [
                            "description" => "该商家支持开发票，请在下单时填写好发票抬头",
                            "icon_color"  => "999999",
                            "icon_name"   => "票",
                            "id"          => 4,
                            "name"        => "开发票",
                        ]
                    ],
                    'rating'                     => sprintf('%s.%s', mt_rand(3, 4), mt_rand(2, 9)),
                    'recent_order_num'           => mt_rand(1, 100),
                    "delivery_mode"              => [
                        "color"    => "57A9FF",
                        "id"       => 1,
                        "is_solid" => true,
                        "text"     => "蜂鸟专送"
                    ],
                    'float_minimum_order_amount' => mt_rand(18, 22),
                    'piecewise_agent_fee'        => [
                        'tips' => '配送费4元'
                    ],
                    'distance'                   => mt_rand(1000, 9999),
                    'order_lead_time'            => sprintf("%d小时%d分钟", mt_rand(1, 2), mt_rand(1, 50)),
                ];
        }

        $this->responseSuccess('', $result);
    }

    /***
     * 关键字地址搜索
     * @throws \ErrorException
     */
    public function pois()
    {
        $keywords = input('keyword');
        $curl = new Curl();
        $curl->get(config('amap.keywords_search_url'), [
            'key'      => config('amap.keywords_search_key'),
            'keywords' => $keywords,
            'city'     => '成都',
            'offset'   => 15,
        ]);
        !$curl->error || $this->responseSuccess($curl->errorMessage, []);
        $response = ($curl->response)->pois;
        $result = [];
        foreach ($response as &$val) {
            $result[] = [
                'name'     => $val->name,
                'address'  => $val->address,
                'location' => $val->location,
            ];
        }
        $this->responseSuccess('', $result);
    }
}