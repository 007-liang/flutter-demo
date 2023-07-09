library utils;

export 'parts/custom_dialog.dart';
export 'parts/check_is_login.dart';
export 'parts/request.dart';
export 'parts/check_is_vip.dart';
export 'parts/lifecycle_wrapper.dart';
export 'parts/share.dart';

import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class Utils {
  static Logger logger = Logger();
  static GetStorage storage = GetStorage();
}
