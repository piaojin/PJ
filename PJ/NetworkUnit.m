//
//  NetworkUnit.m
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "NetworkUnit.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@implementation NetworkUnit


@synthesize networkType;


static Reachability *tReachability = nil;

+(id)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkUnit alloc] init];
        
        [sharedInstance addObserverReachabilityChanged];
    });
    
    return sharedInstance;
}

-(void)addObserverReachabilityChanged{
    
    tReachability = [Reachability reachabilityForInternetConnection];
    [tReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChangedNet:) name: kReachabilityChangedNotification object: nil];
    
}

-(void)reachabilityChangedNet:(NSNotification* )note{
    
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus){
        case ReachableViaWWAN:
        {
            self.networkType = [NetworkUnit getNetworkTypeFromStatusBar];
            break;
        }
        case ReachableViaWiFi:
        {
            self.networkType = NETWORK_TYPE_WIFI;
            break;
        }
        case NotReachable:
        {
            self.networkType = NETWORK_TYPE_NONE;
            break;
        }
        default:
            break;
    }
}


+(NETWORK_TYPE)getNetworkTypeFromStatusBar {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NETWORK_TYPE nettype = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    int type = [num intValue];
    if (type == 5) {
        nettype = NETWORK_TYPE_WIFI;
    }else if (type == 1){
        nettype = NETWORK_TYPE_2G;
    }else if (type == 2){
        nettype = NETWORK_TYPE_3G;
    }else if (type == 3){
        nettype = NETWORK_TYPE_4G;
    }else if (type == 6){
        nettype = NETWORK_TYPE_3G;//共享也归类到3g 
    }
    
    return nettype;
}



+(NSString*)getNetworkTypeDescription{

    NETWORK_TYPE type =  [[NetworkUnit sharedInstance] networkType];
    if (type == NETWORK_TYPE_WIFI) {
        return @"WIFI";
    }else if (type == NETWORK_TYPE_2G){
        return @"2G";
    }else if (type == NETWORK_TYPE_3G){
        return @"3G";
    }else if (type == NETWORK_TYPE_4G){
        return @"4G";
    }else{
        return @"NON";
    }
}

+ (BOOL) isWifiNetWork{
    
    return [NetworkUnit getNetworkTypeFromStatusBar] == NETWORK_TYPE_WIFI;
}

+ (BOOL) is3GAbove{
    
    return [NetworkUnit getNetworkTypeFromStatusBar] > NETWORK_TYPE_2G;
}

+ (BOOL) is2GNetWork{
    
    return [NetworkUnit getNetworkTypeFromStatusBar] == NETWORK_TYPE_2G;
}

+ (BOOL) isNoNetWork{
    
    // 某些情况下 系统状态栏显示我网络 但其实有网络  故此用系统方法判断比较保险
//    [NetworkUnit getNetworkTypeFromStatusBar] == NETWORK_TYPE_NONE;
    
    return [tReachability currentReachabilityStatus] == NotReachable;
}


+ (BOOL) isNetWorkNotWifi{
    
    if ([NetworkUnit getNetworkTypeFromStatusBar] < NETWORK_TYPE_WIFI && [NetworkUnit getNetworkTypeFromStatusBar] != NETWORK_TYPE_NONE) {
        return YES;
    }
    
    return NO;
}

@end

