//
//  NSString+HB.h
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PJ)

+ (BOOL)isEmpty:(NSString *)value;

+ (NSString *)ifNilToStr:(NSString *)value;

+ (NSString *)stringWithInteger:(NSInteger)value;

+ (NSString *)stringWithLong:(long)value;

+ (NSString *)stringWithLongLong:(int64_t)value;

+ (NSString *)stringWithFloat:(float)value;

+ (NSString *)stringWithDouble:(double)value;

- (NSString *)urlEncoded;


@end
