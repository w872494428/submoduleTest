//
//  AppServer.h
//  MTReader
//
//  Created by mitu on 2021/7/28.
//

#import <Foundation/Foundation.h>
#import "SYSDevice.h"
#import "sys/utsname.h"
#import <sys/cdefs.h>
#import <AdSupport/ASIdentifierManager.h>
NS_ASSUME_NONNULL_BEGIN

@interface AppServer : NSObject

#pragma mark ---------------------Bundle-------------------
//获取 bundle version版本号
+(NSString*) getLocalAppVersion;
//获取BundleID
+(NSString*) getBundleID;

//获取BundleVersion
+(NSString*) getBundleVersion;

//获取app的名字
+(NSString*) getAppName;

//获取AppstoreID
+(NSString*) getAppstoreID;


+(NSString*) getQuanzhoumituApi;

/**
 Get请求调用
 @param url     url
 @param params  请求参数
 @param success 成功回调
 @param fail    失败回调
 */
+ (void)Get:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail;

+ (void)GetBookShelfList:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail;

+ (void)GetBookRecordList:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail;

+(NSString *)checkAppStoreVersionUpdateTime;

+(void)checkAppStoreVersionUpdateTimeCompletionBlock:(CompletionBlock)completion;

//强制让App直接退出（非闪退，非崩溃）
+(void)exitApplication;
@end

NS_ASSUME_NONNULL_END
