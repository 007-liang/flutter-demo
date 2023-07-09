part of apis;

class AuthApis {
  static getCode(data) {
    return api.connect('Register/sendCode', method: 'post', data: data);
  }

  static loginWithCode(data) {
    return api.connect(
      'Register/login',
      method: 'post',
      data: data,
    );
  }

  static loginWidthPassword(data) {
    return api.connect(
      'Register/loginWithPwd',
      method: 'post',
      data: data,
    );
  }

  static updatePaassword(data) {
    return api.connect(
      'Register/restpwd',
      method: 'post',
      data: data,
    );
  }
}
