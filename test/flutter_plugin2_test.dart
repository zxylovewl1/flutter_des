import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_des/FlutterDes.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_des');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterDes.encrypt({'_major': 98,'_minor': 23,'cmd': 'query','sessionId': '7D2907E8DF8E6A200CF985ED6AB5536D','count': 2}), '42');
  });
}
