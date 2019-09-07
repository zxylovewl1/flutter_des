//
//  EncryptDict.h
//  ZeroGis
//
//  Created by zbcx on 2019/4/25.
//  Copyright © 2019年 wangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptDict : NSObject
//请求参数加密
+(NSDictionary *)encryptDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
