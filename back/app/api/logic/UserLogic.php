<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/28
 * Time: 16:42
 */

namespace app\api\logic;

use app\common\lib\Token;

class UserLogic
{
    /**
     * 用户登录
     * @param $mobile
     * @param null $http_user_agent
     * @param $ip
     * @return array
     */
    public static function login($mobile, $http_user_agent = null, $ip)
    {
        $where = [
            'login_name' => $mobile,
            'is_delete'  => 0,
        ];
        $model = db('member');
        $userInfo = $model->where($where)->find();
        if (!$userInfo) {
            $addData = [
                'nickname'        => '',
                'login_name'      => $mobile,
                'password'        => '',
                'last_login_time' => date('Y-m-d H:i:s'),
                'last_login_ip'   => $ip,
            ];
            $userId = $model->insert($addData, false, true);
        } else {
            $userId = $userInfo['member_id'];
            $model->where('member_id', $userId)->setField([
                'last_login_time' => date('Y-m-d H:i:s'),
                'last_login_ip'   => $ip,
            ]);
        }
        return [
            'token' => Token::createToken($userId)
        ];
    }
}