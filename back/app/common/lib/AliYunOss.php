<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/23
 * Time: 17:35
 */

namespace app\common\lib;


use OSS\OssClient;

class AliYunOss
{
    private static $_instance;

    private function __construct()
    {
    }

    private function __clone()
    {
    }

    /**
     * @return OssClient
     * @throws \OSS\Core\OssException
     */
    public static function getInstance()
    {
        if (!(self::$_instance instanceof OssClient)) {
            $config = config('aliyun_oss');
            self::$_instance = new OssClient($config['KeyId'], $config['KeySecret'], $config['Endpoint']);
        }
        return self::$_instance;
    }

    /**
     * 获取BucketName
     * @return mixed
     */
    public static function getBucketName()
    {
        $config = config('aliyun_oss');
        return $config['BucketName'];
    }
}