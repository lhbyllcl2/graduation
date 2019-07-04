<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/29
 * Time: 17:19
 */

namespace app\common\lib;

use Lcobucci\JWT\Builder;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Parser;
use Lcobucci\JWT\ValidationData;

/**
 * jwt相关
 * Class Jwt
 * @package app\common\lib
 */
class Token
{
    /**
     * 创建token
     * @param null $uid
     * @return string
     */
    public static function createToken($uid = null)
    {
        $signer = new Sha256();
        $time = time();
        $token = (new Builder())->setIssuer(config('jwt_config.issuer'))
            ->setAudience(config('jwt_config.audience'))
            ->setId(config('jwt_config.id'))
            ->setIssuedAt($time)
            ->setNotBefore($time)
            ->setExpiration($time + intval(config('jwt_config.expiration_time')))
            ->set('uid', $uid)
            ->sign($signer, config('jwt_config.signer'))
            ->getToken();
        return (string)$token;
    }

    /**
     * 验证token
     * @param $token
     * @return bool
     */
    public static function validateToken($token)
    {
        try {
            $token = (new Parser())->parse((string)$token);
            $signer = new Sha256();
            if (!$token->verify($signer, config('jwt_config.signer'))) {
                return false;
            }

            $validationData = new ValidationData();
            $validationData->setIssuer(config('jwt_config.issuer'));
            $validationData->setAudience(config('jwt_config.audience'));
            $validationData->setId(config('jwt_config.id'));

            if ($token->validate($validationData)) {
                return $token->getClaim('uid');
            };
            return false;
        } catch (\Exception $e) {
            return false;
        }
    }
}