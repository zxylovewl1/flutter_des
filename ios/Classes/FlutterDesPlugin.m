#import "FlutterDesPlugin.h"
#import "EncryptDict.h"

@implementation FlutterDesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
   FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_des"
                                     binaryMessenger:[registrar messenger]];
    FlutterDesPlugin* instance = [[FlutterDesPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"encrypt" isEqualToString:call.method]) {
        NSInteger _major = call.arguments[@"_major"];
        NSInteger _minor = call.arguments[@"_minor"];
        NSString *cmd = call.arguments[@"cmd"];
        NSString *sessionid = call.arguments[@"sessionid"];
        NSInteger count = call.arguments[@"count"];
        
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              cmd, @"cmd",
                              _major, @"_major",
                              _minor, @"_minor",
                              count, @"count",
                              sessionid, @"sessionid",
                              nil];
        data = [EncryptDict encryptDict:data];
        result([data objectForKey:@"_code"]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
