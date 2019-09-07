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
        NSString *sessionId = call.arguments[@"sessionid"];
        NSInteger count = call.arguments[@"count"];
        
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              cmd, @"cmd",
                              _major, @"_major",
                              _minor, @"_minor",
                              count, @"count",
                              nil];
        NSLog(@"---加密前的data---:%@",data);
        data = [EncryptDict encryptDict:data];
        NSLog(@"---加密之后的data---:%@",data);
        result([data objectForKey:@"code"]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
