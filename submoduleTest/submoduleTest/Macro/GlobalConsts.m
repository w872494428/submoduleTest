//
//  GlobalConsts.m
//  MTReader
//
//  Created by mitu on 2021/8/12.
//

#import <Foundation/Foundation.h>

NSString * const kStoreAppId = @"1581949973";


NSString * _Nonnull const CFBundleID(void){ //define--2
    return [AppServer getBundleID];
};

NSString * _Nonnull const CFVersion(void){
    return [AppServer getLocalAppVersion];
};

NSString * _Nonnull const CFAppName(void){
    return [AppServer getAppName];
}

NSString * _Nonnull const CFBundleVersion(void){
    return [AppServer getBundleVersion];
}

NSString * _Nonnull const MiTuH5UrlApi(void){
    return [AppServer getQuanzhoumituApi];
}

NSString * _Nonnull const GetAppStoreUpdateTime(void){
    return [AppServer checkAppStoreVersionUpdateTime];
}


NSString * const SaltCaseID = @"ID110120";
#warning -  测试：每个版本必须调整！！！！！！！！
//初版时间——20210825
NSString * const lastReleaseTime = @"20220825"; //测试：每个版本必须调整！！！！待定——>如果Appdelegate.m中走AppStore交互的话就要设置
#warning -  测试：每个版本必须调整！！！！！！！！
NSString * const reviewEndTime = @"20220902";



























































NSString * const achievedTime0 = @"20220930";
NSString * const achievedTime1 = @"20221015"; //测试：上线时候需要调整日期
NSString * const achievedTime2 = @"20221115"; //测试：上线时候需要调整日期
NSString * const achievedTime3 = @"20230115"; //测试：上线时候需要调整日期

