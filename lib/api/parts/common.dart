part of apis;

abstract class CommonApis {
  // 上传图片
  static uploadImage(XFile file) {
    // print('ddd${file.}')
    FormData formData =
        FormData({"images": MultipartFile(file.path, filename: file.name)});
    return api.connect('Register/uploads', method: 'post', data: formData);
  }

  // 获取全局设置
  static fetchConfig() {
    return api.connect('Register/config');
  }
  
  // 获取服务协议
  static fetchAgreement() {
    return api.connect('Register/agreement');
  }

  // 获取隐私协议
  static fetchAgreetext() {
    return api.connect('Register/agreetext');
  }

  static fetchFunctionState(int id) {
     return api.connect('register/isTrial',query: {
       "id": "$id"
     });
  }
  
}
