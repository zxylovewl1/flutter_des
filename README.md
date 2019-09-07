[![build status](https://travis-ci.org/OctMon/flutter_des.svg?style=flat-square)](https://travis-ci.org/OctMon/flutter_des)
[![Pub](https://img.shields.io/pub/v/flutter_des.svg?style=flat-square)](https://pub.dartlang.org/packages/flutter_des)
[![support](https://img.shields.io/badge/platform-flutter-ff69b4.svg?style=flat-square)](https://github.com/OctMon/flutter_des)

# flutter_des

Java, android, ios, get the same result by DES encryption and decryption.

<div >
  <p>
    <img src="https://github.com/OctMon/flutter_des/blob/assets/android.png?raw=true" width = 37% />
    <img src="https://github.com/OctMon/flutter_des/blob/assets/ios.png?raw=true" width = 30.5% />
  </>
</div>

DES
Algorithm: CBC
Operation: (android)PKCS5Padding (ios)kCCOptionPKCS7Padding
http://tool.chacuo.net/cryptdes

## Getting Started

### Add dependency

```yaml
dependencies:
  flutter_des: ^1.1.0  #latest version
```

### Example

```dart
import 'package:flutter_des/flutter_des.dart';

void example() async {
  String platformVersion = await FlutterDes.encrypt(
            {'_major': 98, '_minor': 23, 'cmd': 'query', 'sessionid': '7D2907E8DF8E6A200CF985ED6AB5536D', 'count': 2});
}
```
