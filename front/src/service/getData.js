import request from '../config/fetch'

/***
 * 获取msite页面食品分类列表
 */
export const msiteFoodTypes = () => request.fetchPost('/msite/food/type');
/**
 * 获取商铺列表
 * @returns {*}
 */
export const shopList = () => request.fetchPost('/msite/shop/lists');
/**
 * 获取shop页面商铺详情
 */

export const shopDetails = shop_id => request.fetchPost('/shopping/details/shop_id', {
  shop_id
});


/**
 * 获取shop页面菜单列表
 */

export const foodMenu = shop_id => request.fetchPost('/shopping/menu/shop_id', {
  shop_id
});


/**
 * 获取商铺评价列表
 */

export const getRatingList = (shop_id) => request.fetchPost('/shopping/comment/lists', {
  shop_id
});


/**
 * 获取商铺评价分数
 */

export const ratingScores = shop_id => request.fetchPost('/shopping/comment/scores', {
  shop_id
});


/**
 * 获取商铺评价分类
 */

export const ratingTags = shop_id => request.fetchPost('/shopping/comment/tags', {
  shop_id
});


/**
 * 获取短信验证码
 */

export const mobileCode = phone => request.fetchPost('/user/verify_code/send', {
  mobile: phone
});

/**
 * 发送帐号
 */

export const sendMobile = (sendData, captcha_code, type, password) => fetch('/v1/mobile/verify_code/send', {
  action: "send",
  captcha_code,
  [type]: sendData,
  type: "sms",
  way: type,
  password,
}, 'POST');


/**
 * 加入购物车
 */

export const checkout = (entities, shopid) => request.fetchPost('/shopping/carts/checkout', {
  entities,
  restaurant_id: shopid,
});


/**
 * 获取快速备注列表
 */

export const getRemark = () => request.fetchPost('/shopping/order/remarks');


/**
 * 搜索地址
 */

export const searchNearby = keyword => request.fetchPost('/address/search/pois', {
  keyword
});


/**
 * 添加地址
 */

export const postAddAddress = (address, address_detail, geohash, name, phone, phone_bk, sex, tag) => request.fetchPost('/user/address/add', {
  address,
  address_detail,
  geohash,
  name,
  phone,
  phone_bk,
  sex,
  tag
});


/**
 * 下订单
 */

export const placeOrders = (cart_id, address_id, description, entities) => request.fetchPost('/shopping/order/confirm', {
  cart_id,
  address_id,
  description,
  entities,
});


/**
 * 重新发送订单验证码
 */

export const rePostVerify = (cart_id, sig, type) => fetch('/v1/carts/' + cart_id + '/verify_code', {
  sig,
  type,
}, 'POST');

/**
 * 重新发送订单验证
 */

export const payRequest = (merchantOrderNo) => request.fetchPost('/shopping/order/queryOrder', {
  merchantOrderNo,
});


/**
 * 获取服务中心信息
 */

export const getService = () => fetch('/v3/profile/explain');


/**
 *兑换会员卡
 */

export const vipCart = (id, number, password) => fetch('/member/v1/users/' + id + '/delivery_card/physical_card/bind', {
  number,
  password
}, 'POST')

/**
 * 获取用户信息
 */

export const getUser = () => request.fetchPost('/api/user/get_user');


/**
 * 手机号登录
 */

export const sendLogin = (mobile, validate_token) => request.fetchPost('/user/login/app_mobile', {
  mobile,
  validate_token
});


/**
 * 获取订单列表
 */

export const getOrderList = (offset) => request.fetchPost('shopping/order/orderLists', {offset});


/**
 * 获取订单详情
 */

export const getOrderDetail = (order_id) => request.fetchPost('shopping/order/orderDetails', {order_id});
/***
 * 确认支付
 * @param orderid
 * @returns {*}
 */
export const orderConfrimPay = (order_id) => request.fetchPost('shopping/order/confrimPay', {
  order_id
});
export const orderEvaluate = (order_sn, rating1, rating2, contents) => request.fetchPost('shopping/order/evaluate', {
  order_sn,
  rating1,
  rating2,
  contents
});

/**
 *个人中心里编辑地址
 */

export const getAddressList = () => request.fetchPost('/user/address/lists');

/**
 * 删除地址
 */

export const deleteAddress = (userid, addressid) => fetch('/v1/users/' + userid + '/addresses/' + addressid, {}, 'DELETE')

/**
 * 退出登录
 */
export const signout = () => fetch('/v2/signout');


/**
 * 改密码
 */
export const changePassword = (username, oldpassWord, newpassword, confirmpassword, captcha_code) => fetch('/v2/changepassword', {
  username,
  oldpassWord,
  newpassword,
  confirmpassword,
  captcha_code
}, 'POST');
