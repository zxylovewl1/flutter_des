//
//  EncryptDict.m
//  ZeroGis
//
//  Created by zbcx on 2019/4/25.
//  Copyright © 2019年 wangyao. All rights reserved.
//

#import "EncryptDict.h"
#import "Base64DES.h"

@implementation EncryptDict

+(NSString *)makeKey
{
    NSString *secretKey =@"";
    NSString *sessionId = @"sessionid";
    NSInteger currentCount = 1;
    NSInteger count =  ++currentCount;
    
    if (sessionId != nil) {
        secretKey = [NSString stringWithFormat:@"%@%ld-whzbcx",[sessionId substringToIndex:2],count];
    }
    //取前8位作为秘钥
    secretKey = [secretKey substringToIndex:8];
    return secretKey;
}


+(NSString *)makeKeyCount:(NSDictionary *)dict
{
    NSString *secretKey =@"";
    NSString *sessionId = [dict objectForKey:@"sessionid"];
    NSInteger count =  [dict objectForKey:@"count"];
   
    if (sessionId != nil) {
        secretKey = [NSString stringWithFormat:@"%@%ld-whzbcx",[sessionId substringToIndex:2],count];
    }
    
    secretKey = [secretKey substringToIndex:8];
    return secretKey;
}


//请求参数加密
+(NSDictionary *)encryptDict:(NSDictionary *)dict
{
    NSString * secretKey = [self makeKeyCount:dict];
    NSArray *allkeyInArray = [dict allKeys];
    NSString *code = @"";
    //加密cmd、_major、_minor
    if ([allkeyInArray containsObject:@"cmd"]) {
        code = [NSString stringWithFormat:@"cmd=%@",[dict objectForKey:@"cmd"] ];
    }
    
    if ([allkeyInArray containsObject:@"_major"]) {
        code = [NSString stringWithFormat:@"%@&_major=%@",code,[dict objectForKey:@"_major"] ];
    }
    
    if ([allkeyInArray containsObject:@"_minor"]) {
        code = [NSString stringWithFormat:@"%@&_minor=%@",code,[dict objectForKey:@"_minor"] ];
    }
    
    code = [Base64DES base64StringFromText:code key:secretKey];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 code, @"_code",
                                 [dict objectForKey:@"sessionid"],@"sessionid",
                                 nil];
    //剩余参数参数加入到字典中
    for (NSString *key in allkeyInArray) {
        if (![key isEqualToString:@"cmd"]&&
            ![key isEqualToString:@"_major"]&&
            ![key isEqualToString:@"_minor"]) {
            [data setValue:[dict objectForKey:key] forKey:key];
        }
    }
    
    return (NSDictionary *)data;
}
@end

