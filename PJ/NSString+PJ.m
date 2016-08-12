//
//  NSString+PJ.m
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "NSString+PJ.h"


@implementation NSString (PJ)

+ (BOOL)isEmpty:(NSString *)value {
    if ((value == nil) || value == (NSString *)[NSNull null] || (value.length == 0))
    {
        return YES;
    }
    return NO;
}

+ (NSString *)ifNilToStr:(NSString *)value {
    if ((value == nil) || (value == (NSString *)[NSNull null]))
    {
        return @"";
    }
    return value;
}

+ (NSString *)stringWithInteger:(NSInteger)value {
    NSNumber *number = [NSNumber numberWithInteger:value];
    return [number stringValue];
}

+ (NSString *)stringWithLong:(long)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)stringWithLongLong:(int64_t)value {
    return [NSString stringWithFormat:@"%lld", value];
}

+ (NSString *)stringWithFloat:(float)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)stringWithDouble:(double)value {
    return [NSString stringWithFormat:@"%lf", value];
}

- (NSString *)urlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

@end
