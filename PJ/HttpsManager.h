//
//  HttpsManager.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsManager : NSObject

+ (void)requestGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)requestPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
