import 'dart:io';

import 'package:flutter/foundation.dart';

class Util {
  static isWeb() {
    return kIsWeb;
  }

  static supportUnixSocket() {
    if (kIsWeb) {
      return false;
    }
    return Platform.isLinux || Platform.isMacOS || Platform.isAndroid;
  }
}
