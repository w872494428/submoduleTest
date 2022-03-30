//
//  DY_Common.h
//  DYM
//
//  Created by Linyoung on 2018/4/3.
//  Copyright © 2018年 Linyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DY_Common : NSObject

/**
 *  通过一个颜色绘制一个 uiimage
 */
+ (UIImage *)drawImageWithColor:(UIColor *)color ImgSize:(CGSize)imgSize;

+ (CGFloat)adapteFontWithFontSize:(CGFloat)fontsize;

/**
 *  UIColor转#ffffff格式的字符串
 */
+ (NSString *)hexStringFromColor:(UIColor *)color;

/**
 *  十六进制字符串转UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alphaValue;

/**
 *  正则匹配
 */
+ (BOOL)regexString:(NSString*)stringToSearch withRegex:(NSString*)regexString;
/**
 * 判断手机号码是否合法
 */
+ (BOOL)valiMobile:(NSString *)mobile;
/**
 * 判断URL是否合法
 */
+ (BOOL)valiUrl:(NSString *)url;

/**
 * 判断银行卡号是否合法
 */
+ (BOOL)valiBankCard:(NSString *)cardNo;

/**
 *  字符串是否为纯数字
 */
+ (BOOL)validateNumber:(NSString *)number;

/**
 * 判断邮箱是否合法
 */
+ (BOOL)validateEmail: (NSString *) candidate;

/**
 * 判断字符串是不是都是数字
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  字符串是否为纯数字和小数
 */
+ (BOOL)validateNumber:(NSString *)number decimal:(NSInteger)decimal;

/**
 * 判断身份证号是否正确
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

+ (NSString *)bookTextFormat:(NSString *)formatText;

/**
 * 判断字符串是不是由数字跟字母组成
 */
+ (BOOL)isCompositionWithNumbersAndLetters:(NSString *)string;

/**
 * 判断字符串是不是float 或者int
 */
+ (BOOL)isPureFloat:(NSString *)string;

// 返回拼接字符串
+ (NSString *)urlString:(NSString *)paramsString;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

// 处理中文链接
+ (NSString *)percentUrl:(NSString *)oriUrl;

// 获取当前NaC或者VC
+ (UIViewController *)getCurrentNaC;

// 获取当前VC
+ (UIViewController *)getCurrentVC;


// 获取上一个viewController
+ (UIViewController *)obtainPreviousViewController;

// 跳过某个控制器返回
+ (BOOL)jumpOverViewController:(NSString *)VcName;

// 返回到某个控制器
+ (BOOL)backOverViewController:(NSString *)VcName;

+ (CGSize)sizeWithAdjustWeightWithContent:(NSString *)contentStr
                                     font:(UIFont *)font
                        constrainedHeight:(float)height;
///生成二维码
+ (UIImage *)getQrCodeImageWithContent:(NSString *)content;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

/**
 给view指定的边加上圆角
 
 @param view 需要处理的view
 @param corners 边
 */
+ (void)addFillet:(UIView *)view corners:(UIRectCorner)corners;

/**
 设置图片大小
 
 @param img 需要修改的图片
 @param newSize 图片大小
 @return 指定大小的图片
 */
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize;


/**
 获取字符串的数字

 @param str 字符串
 @return 字符串里面的数字
 */
+ (NSString *)getTheNumberOfTheString:(NSString *)str;

/**
 真四舍五入
 
 @param price 值
 @return 四舍五入后的值
 */
+ (float)roundFloat:(float)price;

/**
 计算两个时间的间隔(毫秒)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSTimeInterval)contrastTimeWithStartDate:(NSString *)start endDate:(NSString *)end;

/**
 计算两个时间的间隔(秒)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackSecondWithStartDate:(NSString *)start endDate:(NSString *)end;


/**
 计算两个时间的间隔(分)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackMinuteWithStartDate:(NSString *)start endDate:(NSString *)end;

/**
 计算两个时间的间隔(小时)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackHourWithStartDate:(NSString *)start endDate:(NSString *)end;

/**
 计算两个时间的间隔(天)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackDayWithStartDate:(NSString *)start endDate:(NSString *)end;

/*
 * 整形时间戳转换为datetime时间字符串
 */
+ (NSString *)time_timestampToString:(NSInteger)timestamp setDateFormatStr:(nullable NSString *)formatString;

/**
 裁切图片(变成圆形)
 
 @param image 需要裁切的图片
 @return 圆形图片
 */
+ (UIImage *)circleImageWithImg:(UIImage *)image;



/**
 金额格式处理
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (NSString *)formatDecimalNumber:(NSString *)string ;

/**
 批量下载图片
 保持顺序;
 全部下载完成后才进行回调;
 回调结果中,下载正确和失败的状态保持与原先一致的顺序;
 
 @return resultArray 中包含两类对象:UIImage , NSError.过滤了error类型
 */
+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock;


/// 压缩图片直到设置的大小
/// @param image
/// @param maxLength 
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

/// 查询设备ID
+ (NSString *)queryKeyChainIDByKey:(NSString *_Nullable)keychainStr;
/// 保存设备ID
+ (void)saveKeyChainIDByKey:(NSString *_Nullable)keychainStr;
/// 获取设备ID
+ (NSString *)getDeviceIdWithKey:(NSString *_Nullable)keychainStr;
+ (NSString *)getChainString:(NSString *_Nullable)chainStr withChainKey:(NSString *_Nullable)chainKey;
+ (void)createChainString:(NSString *_Nullable)chainStr withChainKey:(NSString *_Nullable)chainKey;

+ (void)deleteKeyChainWithKey:(NSString *_Nullable)keychainStr;
/// 删除设备ID
+ (void)deleteDeviceIdWithKey:(NSString *_Nullable)keychainStr;

/// 网络状态
+ (NSString *)getNetconnType;

+(void)evaluateAppstoreScoresWithAppID:(NSString *)appId;

/**
 获取缓存大小
 
 @return 缓存大小
 */
+ (NSString *)getCachesSize;

/**
 清除缓存
 */
+ (void)removeCache;

+ (UILabel *)categoryLabelWithTitleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;


+(NSArray *)randomArray:(NSArray *)arr;

+(NSInteger)checkLimitConditionCurrentTime;

// 拼接参数
+ (NSString *)getParams:(NSDictionary *)params;
@end
