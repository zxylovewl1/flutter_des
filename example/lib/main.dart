import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_des/FlutterDes.dart';

void main()
=> runApp(MyApp());

class MyApp extends StatefulWidget
{
  @override
  _MyAppState createState()
  => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  String _platformVersion = 'Unknown';

  @override
  void initState()
  {
    super.initState();
    initPlatformState();
  }

  static Future<String> encryptAndroid(String majorMinorCmd,
      String sessionId, int count)
  async {
    Map<String, dynamic> params = <String, dynamic>{
      'majorMinorCmd': majorMinorCmd,
      'sessionId': sessionId,
      'count': count,
    };
  }


  static Future<String> encrypt(dynamic major, dynamic minor, dynamic cmd,
      String sessionId, int count)
  async {
    Map<String, dynamic> params = <String, dynamic>{
      '_major': major,
      '_minor': minor,
      'cmd': cmd,
      'sessionId': sessionId,
      'count': count,
    };
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState()
  async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try
    {
      platformVersion =
      await FlutterDes.encrypt(
          {'_major': 98, '_minor': 23, 'cmd': 'query', 'sessionid': '7D2907E8DF8E6A200CF985ED6AB5536D', 'count': 2});
    }
    on PlatformException
    {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(()
    {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
