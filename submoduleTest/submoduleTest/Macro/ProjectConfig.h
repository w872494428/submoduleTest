//
//  ProjectConfig.h
//  MTReader
//
//  Created by mitu on 2021/8/4.
//

#ifndef ProjectConfig_h
#define ProjectConfig_h
#import <objc/objc.h>   //for"Unknown type name 'BOOL'"

///开关设置
static BOOL const SPLASHAD_MODE = NO;//NO不展示广告、YES展示广告
static BOOL const GUIDE_MODE = NO;//NO不显示欢迎页、YES显示欢迎页
static BOOL const SIGN_MODE = NO;//NO不需要强制登录、YES需要强制登录
/** 开发模式 */
static BOOL const DEVELOPER_MODE = NO;
/** 企业版本 || App Store */
static BOOL const IsEnterpriseVersion = NO;

#warning - 测试：每个版本必须调整！！！！！！！！
static BOOL const Clear_KeyChain_Cache = YES;/*测试：
                                                  1.0.0版本测试后置为NO 【不删除钥匙串缓存，记住webview的访问地址keychainStr】
                                                  1.0.1版本测试后置为YES【YES删除钥匙串缓存】
                                              */

#warning - 测试：每个版本必须调整！！！！！！！！
//说明：是否执行服务器接口请求服务，NO为本地数据，YES为服务请求数据
static BOOL const Check_Http_Mode = NO;/*测试：
                                         1.0.0版本测试后置为YES 【YES走后台接口请求数据】
                                         1.0.1版本测试后置为NO 【NO不走服务器，执行本地数据信息】
                                        */

//宏定义
#define FLAG_APP_FIRSTLAUNCH            @"AppFirstStart" //首次安装：0首次安装、1未安装

#define FLAG_KEYCHAIN_UUID              @"KeyChainUUID"
#define FLAG_KEYCHAIN_SHADOW            @"KeyChainShadow"

//Notify通知
#define UPDATE_ACCOUNT_INFO             @"UpdateAccountInfo"
#define kReadTimeReloadNotify           @"kReadTimeReloadNotify"

//FMDB:DataTable名称
#define kSaveBookSheftDataList          @"kSaveBookSheftList" //保存书架列表
#define kSaveLastBookDataList           @"kSaveLastBookList" //保存最后一本书
#define kSaveBookRecordDataList         @"kSaveBookRecordList" //阅读记录


// 夜间模式
#define kNightStyleNotify               @"kNightStyleNotify"
// 护眼模式
#define kProtectStyleNotify             @"kProtectStyleNotify"

// 监听观看视频用户的Vip情况
#define kReadVideoVipGetNotify          @"kReadVideoVipGetNotify"
// 阅读界面显示阅读设置
#define kReadContentTouchEndNotify      @"kReadContentTouchEndNotify"
// 阅读时间动画
#define kReadTimeAnimationNotify        @"kReadTimeAnimationNotify"



#endif /* ProjectConfig_h */
