//
//  ValueValidator.h
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueValidator : NSObject {

}
+ (BOOL)isNSNull:(NSDictionary *)responseDict key:(NSString *)key;

+ (BOOL)isNuLLForArray:(NSArray *)array;

+ (BOOL)isNuLLForSet:(NSSet *)set;

@end
