part of apis;

abstract class ContactsApis {
  // 获取全局设置
  static fetchContactsList(query) {
    return api.connect('Register/friendList', query: query);
  }

  // 更新联系人信息
  static addContacts(data) {
    return api.connect('Register/addFriend', method: 'post', data: data);
  }

  // 更新联系人信息
  static updateContacts(data) {
    return api.connect('Register/updateFriend', method: 'post', data: data);
  }

  // 删除联系人
  static deleteContacts(data) {
    return api.connect('Register/delFriend', method: 'post', data: data);
  }

  // 检测是否存在用户
  static checkIsMmber(query) {
    return api.connect('register/isMember', query: query);
  }

  //同意or拒绝申请
  static hanlderApply(data) {
    return api.connect('register/accept', method: 'post', data: data);
  }

  //获取好友轨迹
  static fetchTraceList(query) {
    return api.connect('register/getLocationList', query: query);
  }
}
