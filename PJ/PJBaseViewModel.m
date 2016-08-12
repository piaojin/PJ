//
//  PJBaseViewModel.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseViewModel.h"
#import "HttpsManager.h"

@implementation PJBaseViewModel

+ (void)requestGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HttpsManager requestGet:url params:params success:success failure:failure];
}

+ (void)requestPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HttpsManager requestPost:url params:params success:success failure:failure];
}

- (void)requestGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HttpsManager requestGet:url params:params success:success failure:failure];
}

- (void)requestPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [HttpsManager requestPost:url params:params success:success failure:failure];
}


@end
