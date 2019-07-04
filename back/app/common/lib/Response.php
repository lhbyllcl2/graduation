<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/10
 * Time: 14:04
 */

namespace app\common\lib;

use think\Lang;

/***
 * 接口响应公共方法
 * Trait Response
 * @package app\common\lib
 */
trait Response
{
    private $errMessage = null; //系统的错误消息

    private $errCode = 0; //系统的错误码

    private $returnData = []; //返回的数据

    /**
     * 服务器响应数据为json格式
     */
    private function responseJson()
    {
        $return = json_encode(
            [
                'code'    => $this->errCode,
                'message' => $this->errMessage,
                'data'    => $this->returnData
            ]
        );
        exit($return);
    }


    /**
     * 请求成功的返回
     * @param string $msg
     * @param array $data
     */
    protected function responseSuccess($msg = 'success', $data = [])
    {
        $this->errCode = 200; //成功返回码
        $this->errMessage = $msg;
        $this->returnData = $data;
        $this->responseJson();
    }

    /**
     * 设置错误消息和错误码
     * @param int $code 错误码
     * @param array $data
     * @param null $message
     */
    protected function responseError($code = 1000, $data = [], $message = null)
    {
        $this->errCode = $code;
        $this->returnData = $data;
        Lang::load(APP_PATH . 'common\lang\zh-cn.php');
        $this->errMessage = Lang::get('ERR_CODE')[$code];
        if ($message !== null) {
            $this->errMessage = sprintf($this->errMessage, $message);
        }
        $this->responseJson();
    }
}