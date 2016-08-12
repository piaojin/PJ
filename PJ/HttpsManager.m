//
//  HttpsManager.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "HttpsManager.h"
#import "AFNetworking.h"
#import "NSString+PJ.h"

@implementation HttpsManager

+ (void)requestGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    if(![NSString isEmpty:url]){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(responseObject){
                if(success){
                    success(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure){
                failure(error);
            }
        }];
    }else{
        NSLog(@"url为空！");
    }
}

+ (void)requestPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    if(![NSString isEmpty:url]){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(responseObject){
                if(success){
                    success(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure){
                failure(error);
            }
        }];
    }else{
        NSLog(@"url为空！");
    }
}

@end
