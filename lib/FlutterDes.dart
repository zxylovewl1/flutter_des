import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDes
{
  static const MethodChannel _channel = const MethodChannel('flutter_des');

  /*
   * FlutterDes加密
   *
   * @param param={'_major': 98,'_minor': 23,'cmd': query,'sessionid': 7D2907E8DF8E6A200CF985ED6AB5536D,'count': 2}
   */
  static Future<String> encrypt(dynamic params)
  async {
    final String version = await _channel.invokeMethod('encrypt', params);
    return version;
  }
}
