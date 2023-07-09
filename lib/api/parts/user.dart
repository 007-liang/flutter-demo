part of apis;

abstract class UserApis {
  static fetchUserInfo() {
    return api.connect('Register/singleInfo');
  }

  // 领取试用
  static fetchPrime() {
    return api.connect('register/trial');
  }

  // 获取
  static fetchPackageList() {
    return api.connect('Payment/goodslist');
  }

  // 购买vip
  static buyVip(data) {
    return api.connect('Payment/alipay', method: 'post', data: data);
  }

  // 修改用户信息
  static updateUserInfo(data) {
    return api.connect('Register/editInfo', method: 'post', data: data);
  }


  // 消号
  static cancelAccount() {
    return api.connect('Register/selfDelete', method: 'post');
  }

  // 获取通知
  static fetchNoticeList(query) {
    return api.connect('Register/noticeList',query: query);
  }

  // 发送求助
  static updateEmergencyState(data) {
    return api.connect('Register/updateSelfStatus', method: 'post', data: data);
  }

  //判断会员
  static checkIsVip(query) {
    return api.connect('Register/isVip', query: query);
  }
}
