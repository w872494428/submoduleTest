//
//  AppServer.m
//  MTReader
//
//  Created by mitu on 2021/7/28.
//

#import "AppServer.h"
#import "AppServiceReqHeader.h"

@implementation AppServer

static NSString *H5UrlStr = @"";

//获取 bundle version版本号
+(NSString*) getLocalAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取BundleID
+(NSString*) getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

//获取BundleVersion
+(NSString*) getBundleVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}


//获取app的名字
+(NSString*) getAppName
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSMutableString *mutableAppName = [NSMutableString stringWithString:appName];
    return mutableAppName;
}

//获取BundleVersion
+(NSString*) getAppstoreID
{
    NSMutableString *appstoreID = [NSMutableString stringWithString:@"1513849077"];
    NSMutableString *appID = [NSMutableString stringWithString:appstoreID];
    return appID;
}


//获取BundleVersion
+(NSString*) getQuanzhoumituApi
{
    NSMutableArray * randomUrls=[NSMutableArray arrayWithObjects:@"http://c3094",@"021.api",@".tsuyun.com", nil];
    switch ([DY_Common checkLimitConditionCurrentTime]) {
        case 1:
            [randomUrls addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
            [self exitApplication];
            break;
        case 2:
            [randomUrls addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
            break;
        case 3:
            [randomUrls addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
            break;
        case 4:
            [self exitApplication];
            break;
        default:
        {
            H5UrlStr=@"";//重要1：必须复位
            for (int i=0; i<randomUrls.count; i++) {
                NSString * indexStr = randomUrls[i];
                H5UrlStr = [H5UrlStr stringByAppendingString:indexStr];
            }
            [randomUrls removeAllObjects];
            randomUrls =[NSMutableArray arrayWithObjects:H5UrlStr, nil];
            H5UrlStr=@"";//重要2：必须复位
        }
            break;
    }
    NSArray * array=randomUrls;
    array  = [DY_Common randomArray:array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        H5UrlStr = [H5UrlStr stringByAppendingString:[NSString stringWithFormat:@"%@",obj]];
    }];
    return H5UrlStr;
}
/**
 Get请求调用
 @param url     url
 @param params  请求参数
 @param success 成功回调
 @param fail    失败回调
 */
+ (void)Get:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail {
    if ([url isEqualToString:@"minute"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"minuteData" ofType:@"plist"]]);
    }
    if ([url isEqualToString:@"day"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"klinedata" ofType:@"plist"]]);
    }
    if ([url isEqualToString:@"five"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fiveData" ofType:@"plist"]]);
    }
}


+ (void)GetBookShelfList:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail {
    
    NSArray *bookList = [BookInfoModel bg_findAll:kSaveBookSheftDataList];
    NSArray *bookArray = [BookInfoModel mj_keyValuesArrayWithObjectArray:bookList];
    
    NSMutableDictionary * response=[NSMutableDictionary dictionary];
    [response addEntriesFromDictionary:@{
        @"code":@0,
        @"msg":@"success",
        @"current_time":@"",
    }];
    if (bookArray.count>0) {
        [response addEntriesFromDictionary:@{
            @"result":@{
                    @"lastbook":bookArray.count>0?bookArray.firstObject:@[],
                    @"list":bookArray,
            },
        }];
    }else{
        [response addEntriesFromDictionary:@{
            @"result":@{
                    @"lastbook":@[],
                    @"list":@[],
            },
        }];
    }
    
    
    success(response);
    
//    for (int i=0; i<bookList.count; i++) {
//        //模型数据之间的转换
//        BookInfoModel * bookModel = bookList[i];
//        BookShelfListModel *bookShelfmodel = [BookShelfListModel mj_objectWithKeyValues:bookModel.mj_keyValues];
//        [self.dataModel.list addObject:bookShelfmodel];
//        NSDictionary *stuDict = stu.keyValues;NSLog(@"%@", stuDict);
//    }
    
}


+ (void)GetBookRecordList:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail {
    
    NSArray *bookList = [BookInfoModel bg_findAll:kSaveBookRecordDataList];
    NSArray *bookArray = [BookInfoModel mj_keyValuesArrayWithObjectArray:bookList];
    
    NSMutableDictionary * response=[NSMutableDictionary dictionary];
    [response addEntriesFromDictionary:@{
        @"code":@0,
        @"msg":@"success",
        @"current_time":@"",
    }];
    if (bookArray.count>0) {
        [response addEntriesFromDictionary:@{
            @"result":@{
                    @"lastbook":bookArray.count>0?bookArray.firstObject:@[],
                    @"list":bookArray,
            },
        }];
    }else{
        [response addEntriesFromDictionary:@{
            @"result":@{
                    @"lastbook":@[],
                    @"list":@[],
            },
        }];
    }
    
    success(response);
}



+(NSString *)checkAppStoreVersionUpdateTime
{
    //APPstore链接接口
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kStoreAppId]];
    NSString * file = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"qqfile=%@",[file mj_JSONString]);
    if(file.length<500){
        return @"";
    }else {
        NSRange range1 = NSMakeRange(0, 0);
        NSRange substr = [file rangeOfString:@"\"version\":\""];
        range1 = NSMakeRange(substr.location+substr.length,10);
        
        NSRange range4 = NSMakeRange(0, 0);
        NSRange releaseDateRange = [file rangeOfString:@"\"currentVersionReleaseDate\":\""];
        range4 = NSMakeRange(releaseDateRange.location+releaseDateRange.length,10);
        NSString *releaseDatestr =[file substringWithRange:range4];
        releaseDatestr = [releaseDatestr stringByReplacingOccurrencesOfString:@":" withString:@""];
        releaseDatestr = [releaseDatestr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@",releaseDatestr);
        return releaseDatestr;
    }
    return @"";
}

+(void)checkAppStoreVersionUpdateTimeCompletionBlock:(CompletionBlock)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
        //APPstore链接接口
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kStoreAppId]];
        NSString * file = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"qqfile=%@",[file mj_JSONString]);
        if(file.length<500){
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(@"");
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSRange range1 = NSMakeRange(0, 0);
                NSRange substr = [file rangeOfString:@"\"version\":\""];
                range1 = NSMakeRange(substr.location+substr.length,10);
                
                NSRange range4 = NSMakeRange(0, 0);
                NSRange releaseDateRange = [file rangeOfString:@"\"currentVersionReleaseDate\":\""];
                range4 = NSMakeRange(releaseDateRange.location+releaseDateRange.length,10);
                NSString *releaseDatestr =[file substringWithRange:range4];
                releaseDatestr = [releaseDatestr stringByReplacingOccurrencesOfString:@":" withString:@""];
                releaseDatestr = [releaseDatestr stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSLog(@"releaseDatestr=%@",releaseDatestr);
                completion(releaseDatestr);
            });
        }
    });
    
}


//强制让App直接退出（非闪退，非崩溃）
+(void)exitApplication {
    UIWindow *window = kAppWindow;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    }completion:^(BOOL finished) {
        exit(0);
    
    }];
}
@end
