import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/router/index.dart';
import '/utils/index.dart';
import '/controllers/index.dart';

class Api extends GetConnect {
  Api(baseUrl) {
    httpClient.baseUrl = baseUrl;
    httpClient.maxAuthRetries = 0;
  }

  Future<T> connect<T>(String url,
      {method, data, query, Map<String, String> headers = const {}}) async {
    GlobalDataController globalDataController =
        Get.find<GlobalDataController>();
    method = method ?? 'GET';
    Map<String, String> initHeaders = {
      'token': globalDataController.token.value ?? ''
    };
    initHeaders.addAll(headers);
    Utils.logger.i({
      'url': url,
      'method': method,
      'data': data,
      'query': query,
      'headers': initHeaders
    });
    try {
      Response response = await request(url, method,
          body: data, query: query, headers: initHeaders);
      if (response.body['status'] == 1) {
        Utils.logger.d(response.body['data']);
        return response.body['data'];
      } else {
        Utils.logger.d(response.body);
        if ((response.body['code'] is String
                ? int.parse(response.body['code'])
                : response.body['code']) ==
            401) {
          UserController userController = Get.find<UserController>();
          Utils.storage.remove('token');
          globalDataController.updateToken(null);
          userController.userInfo.value = null;
          Get.offAllNamed(Routes.index);
        }
        return throw (response.body['msg']);
      }
    } catch (e) {
      if (e is String) {
        EasyLoading.showError(e);
      }
      Utils.logger.d(e);
      throw Error();
    }
  }
}

Api api = Api(GlobalDataController.baseUrl);
