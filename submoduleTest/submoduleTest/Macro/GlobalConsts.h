//
//  GlobalConsts.h
//  MTReader
//
//  Created by mitu on 2021/7/23.
//

#ifndef GlobalConsts_h
#define GlobalConsts_h
//#import"GLData.h"
//extern GLData * _Nonnull gl_data; //全局化变量
extern CGRect rectNavC;
extern CGRect rectTabbarFrame;
extern NSString * _Nonnull const kStoreAppId;
extern NSString * _Nonnull const CFBundleID(void); //define--1
extern NSString * _Nonnull const CFVersion(void);;
extern NSString * _Nonnull const CFAppName(void);
extern NSString * _Nonnull const CFBundleVersion(void);
extern NSString * _Nonnull const MiTuH5UrlApi(void);
extern NSString * _Nonnull const GetAppStoreUpdateTime(void);

extern NSString * _Nonnull const SaltCaseID;
extern NSString * _Nonnull const lastReleaseTime;
extern NSString * _Nonnull const reviewEndTime;

extern NSString * _Nonnull const achievedTime0;
extern NSString * _Nonnull const achievedTime1;
extern NSString * _Nonnull const achievedTime2;
extern NSString * _Nonnull const achievedTime3;
#pragma mark - 全局方法
typedef void (^HttpClientFail)(NSError * _Nullable error);//http 连接服务器失败
typedef void (^HttpClientReceived)(NSDictionary* _Nullable dict, NSInteger code);//http 读取到数据

typedef void(^RequestSuccessBlock)(NSDictionary * _Nullable resultDic);
typedef void(^RequestFailureBlock)(NSDictionary * _Nullable resultDic);
typedef void(^CheckFailureBlock)(NSDictionary * _Nullable messageDic);

typedef void(^SuccessBlock)(NSDictionary * _Nullable result);
typedef void(^FailureBlock)(NSError * _Nullable error);
typedef void(^CompletionBlock)(NSString * _Nullable string);
typedef void(^ResultBlock)(BOOL isSuccess);
typedef void(^ButtonAction)(void);
typedef void(^HandlerBlock)(void);
typedef void(^ReturnBlock) (void);
typedef void(^ClickedButtonBlock)(id _Nullable data, NSInteger Index);
/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id _Nullable responseObject);
/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError * _Nullable error);
/** 上传图片成功的Block */
typedef void(^HttpUploadSuccess)(id _Nullable responseObject);
/** 上传图片失败的Block */
typedef void(^HttpUploadFailed)(NSError * _Nullable error);

typedef NS_ENUM(NSUInteger, ClentType) {
    Clent_android = 1,
    Clent_ios = 2,
};

typedef NS_ENUM(NSUInteger, CodeGetType) {
    CodeTypeJoin=1,//register、login
    CodeTypeBind=2
};

typedef NS_ENUM(NSUInteger, AppFlatType) {
    AppFlatTypeMLWX=1,//米粒文学
    AppFlatTypeHTXS=2,//海豚小说
    AppFlatTypeYDQ=3  //阅读器
};

typedef enum : NSUInteger {
    TransitionStylePageCurl,
    TransitionStyleLeftRigthScroll,
} PageTransitionStyleType; // 翻页风格

typedef enum : NSUInteger {
    ReadContentTypeBookRead,
    ReadContentTypeCover,
    ReadContentTypeLastPage,
    ReadContentTypeAd,
} ReadContentType;

typedef enum : NSUInteger {
    ReadViewLineSpacing1 = 1,
    ReadViewLineSpacing6 = 6,
    ReadViewLineSpacing12 = 12,
    ReadViewLineSpacing18 = 18,
} ReadViewLineSpacing; // 字体上下间隔

typedef enum : NSUInteger {
    ReadViewBgcolor1,
    ReadViewBgcolor2,
    ReadViewBgcolor3,
    ReadViewBgcolor4,
    ReadViewBgcolor5,
    ReadViewBgcolor6,
    ReadViewBgcolor7,
} ReadViewBgcolor; // 背景颜色

typedef enum : NSUInteger {
    FictionInfo,
    FictionIntroduction,
    FictionRecommend,
    FictionCopyright,
} FictionCell;


///数据

//位数精确度
#define BitNumber   4
//头像圆角（全局）
#define RadiusIcon  4
//极小圆角
#define RadiusTiny    2.0
//小圆角
#define RadiusSmall   4.0
//大圆角
#define RadiusBig     8.0

#define MarginX  20
#define edgeMargin  15
// 边距
#define kMarginX 15.67
#define kMargin 15.67
#define kCellMargin 12

// 线高度
#define kLineHeight 0.3
#define kLineWidth 0.3

//书本宽高
#define kBookIconW kAdjustRatio(77)
#define kBookIconH kAdjustRatio(102)

//标题高度
#define kTitleViewH 44

//上拉高度
#define kUpDragH 100

// 限制字体大小
#define minFontSize 15
#define maxFontSize 28

//图片比例
#define ratioImage 1.333f
#define ratioIcon  1.45f
#endif /* GlobalConsts_h */
