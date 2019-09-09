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
        NSObject * _major = call.arguments[@"_major"];
        NSObject * _minor = call.arguments[@"_minor"];
        NSString *cmd = call.arguments[@"cmd"];
        NSString *sessionid = call.arguments[@"sessionid"];
        NSInteger count = call.arguments[@"_count"];
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              cmd, @"cmd",
                              count, @"count",
                              sessionid, @"sessionid",
                              nil];
        if(_major != nil)
        {
            [data setObject:_major forKey:@"_major"];
        }
        if(_minor != nil)
        {
            [data setObject:_minor forKey:@"_minor"];
        }
        
        data = [EncryptDict encryptDict:data];
        result([data objectForKey:@"_code"]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
