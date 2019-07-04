<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/28
 * Time: 15:18
 */

namespace app\api\controller;


use app\api\logic\UserLogic;
use app\common\controller\ApiBaseController;
use WebGeeker\Validation\Validation;

class UserController extends ApiBaseController
{
    protected $authTokenWhiteList = ['api.User.login', 'api.User.sendVerifyCode'];

    public function getUser()
    {
        $info = db('member')->where('member_id', $this->uid)->find();
        $result = [
            'avatar'      => 'http://lhy01.oss-cn-beijing.aliyuncs.com/cfeea66dbdd4bcfb3ae2cb9a05fbbfae50c56685.jpeg',
            'username'    => $info['login_name'],
            'mobile'      => $info['login_name'],
            'balance'     => 0,
            'gift_amount' => 0,
            'point'       => 0,
        ];
        $this->responseSuccess('', $result);
    }

    /**
     * 登录
     */
    public function login()
    {
        $mobile = input('mobile');
        $validate_token = input('validate_token');
        $validate_token == 9527 || $this->responseError(1001, null, '验证码错误');

        $server = $this->request->server();
        array_key_exists('HTTP_USER_AGENT', $server) || $this->responseError(1001, null, '错误的请求');

        $result = UserLogic::login($mobile, $server['HTTP_USER_AGENT'],$this->request->ip());

        is_array($result) || $this->responseError(1001, $result);
        $this->responseSuccess('', $result);
    }

    /**
     * 添加地址
     */
    public function addAddress()
    {
        $param = input();
        try {
            Validation::validate($param, [
                "address"        => "StrLenGeLe:2,50",
                "address_detail" => "StrLenGeLe:2,60",
                "geohash"        => "Required",
                "name"           => "StrLenGeLe:2,20",
                "phone"          => "Regexp:/^1(3[0-9]|4[579]|5[0-35-9]|7[0135678]|8[0-9]|66|9[89])\d{8}$/",
                "phone_bk"       => "Required",
                "sex"            => "IntIn:1,2",
                "tag"            => "Required",
            ]);
            $where = [
                'member_id'  => $this->uid,
                'is_delete'  => 0,
                'is_default' => 1,
            ];
            $model = db('member_address');
            $defaultExist = $model->where($where)->count();
            $addData = [
                'member_id'      => $this->uid,
                'address_detail' => $param['address'] . $param['address_detail'],
                'name'           => $param['name'],
                'phone'          => $param['phone'],
                'phone_bk'       => $param['phone_bk'],
                'sex'            => $param['sex'],
                'tag'            => $param['tag'],
                'geohash'        => $param['geohash'],
                'is_default'     => $defaultExist ? 0 : 1,
            ];
            $model->insert($addData);
            $this->responseSuccess('ok');
        } catch (\Exception $e) {
            $this->responseError(1001, '', $e->getMessage());
        }
    }

    /***
     * 获取地址列表
     */
    public function addressesLists()
    {
        $where = [
            'member_id' => $this->uid,
            'is_delete' => 0,
        ];
        $res = db('member_address')->where($where)->order(['is_default' => 'desc', 'address_id' => 'desc'])->select();
        $result = [];
        foreach ($res as &$val) {
            $result[] = [
                'id'             => $val['address_id'],
                'name'           => $val['name'],
                'phone'          => $val['phone'],
                'sex'            => $val['sex'],
                'tag'            => $val['tag'],
                'address_detail' => $val['address_detail'],
                'is_deliverable' => 1,//根据商家的距离和用户地址比对哪些是无效的
            ];
        }
        $this->responseSuccess('', $result);
    }

    /**
     * 发送验证码
     */
    public function sendVerifyCode()
    {
        $this->responseSuccess('', ['validate_token' => 9527]);
    }
}