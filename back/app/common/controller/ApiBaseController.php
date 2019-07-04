<?php
/**
 * Created by PhpStorm.
 * User: luohaoyu
 * Date: 2019/4/10
 * Time: 14:36
 */

namespace app\common\controller;

use app\common\lib\Response;
use think\Controller;
use app\common\lib\Token;

/***
 * 接口基类
 * Class ApiBaseController
 * @package app\common\controller
 */
class ApiBaseController extends Controller
{
    use Response;
    protected $authToken = true;         //是否验证用户token
    protected $authTokenWhiteList = [];   //是否验证action的白名单，格式："模块名.控制器名.行为名" ，如 app.User.login
    protected $uid;

    protected function _initialize()
    {
        if (!$this->authToken) {
            return null;
        }
        $routeInfo = $this->request->routeInfo();
        if (array_key_exists('route', $routeInfo)) {
            list($module, $controller, $action) = explode('/', $routeInfo['route']);
        } else {
            $module = $this->request->module();
            $controller = $this->request->controller();
            $action = $this->request->action();
        }
        $currentApi = strtolower(sprintf('%s.%s.%s', $module, $controller, $action));
        $authTokenWhiteList = $this->authTokenWhiteList;
        array_walk($authTokenWhiteList, function (&$item) {
            $item = strtolower($item);
        });
        if (in_array($currentApi, $authTokenWhiteList)) {
            return null;
        }
        $token = $this->request->param('token');
        $token || $this->responseError(1002);
        ($uid = Token::validateToken($token)) || $this->responseError(1003);
        $this->uid = $uid;
    }

}