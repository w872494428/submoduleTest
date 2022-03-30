//
//  DY_Common.m
//  DYM
//
//  Created by Linyoung on 2018/4/3.
//  Copyright © 2018年 Linyoung. All rights reserved.
//

#import "DY_Common.h"
#import "SAMKeychain.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation DY_Common

/**
 *  通过一个颜色绘制一个 uiimage
 */
+ (UIImage *)drawImageWithColor:(UIColor *)color ImgSize:(CGSize)imgSize
{
    CGSize imageSize;
    if (imgSize.width == 0) {
        imageSize = CGSizeMake(10, 10);
    }else{
        imageSize = imgSize;
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

+ (CGFloat)adapteFontWithFontSize:(CGFloat)fontsize {
    //    CGFloat size = kAdjustRatio(fontsize);
    //    return size;
    if (KSCREENW > 400) {
        return 1.3*fontsize;
    } else {
        return fontsize;
    }
    //    if([[DeviceInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[DeviceInfo iphoneType] isEqualToString:@"iPhone 6s Plus"] || [[DeviceInfo iphoneType] isEqualToString:@"iPhone 7 Plus"]) {
    //        //大屏幕
    //        NSLog(@"#%f#",1.5*fontsize);
    //        return 1.5*fontsize;
    //    } else {
    //        return fontsize;
    //    }
}


/**
 *  UIColor转#ffffff格式的字符串
 */
+ (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}


/**
 *  十六进制字符串转UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alphaValue {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (cString.length < 6)
        return [UIColor clearColor];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if (cString.length != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:alphaValue];
}


+ (BOOL)regexString:(NSString*)stringToSearch withRegex:(NSString*)regexString
{
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [regex evaluateWithObject:stringToSearch];
}


+ (BOOL)valiMobile:(NSString *)mobile
{
    if (mobile.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|73|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  字符串是否为纯数字
 */
+ (BOOL)validateNumber:(NSString *)number {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:number];
}

+ (BOOL)valiUrl:(NSString *)url
{
    NSString *urlRegex = @"^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+)\\.)+([A-Za-z]+)[/\?\\:]?.*$";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

+ (BOOL)valiBankCard:(NSString *)cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
    return YES;
    else
    return NO;
}


+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  字符串是否为纯数字和小数
 */
+ (BOOL)validateNumber:(NSString *)number decimal:(NSInteger)decimal {
    NSString *numberRegex = [NSString stringWithFormat:@"^[0-9]+(.[0-9]{0,%ld})?$", decimal];
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:number];
}

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    //    //我们这边就限制 15 或者 18        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;    如果你那边使用的是正则可以给我参考下

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
//    if (identityCard.length != 18) return NO;
//    // 正则表达式判断基本 身份证号是否满足格式
//    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
//    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
//    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    //如果通过该验证，说明身份证格式正确，但准确性还需计算
//    if(![identityStringPredicate evaluateWithObject:identityCard]) return NO;
//
//    //** 开始进行校验 *//
//
//    //将前17位加权因子保存在数组里
//    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
//
//    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
//    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
//
//    //用来保存前17位各自乖以加权因子后的总和
//    NSInteger idCardWiSum = 0;
//    for(int i = 0;i < 17;i++) {
//        NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
//        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
//        idCardWiSum+= subStrIndex * idCardWiIndex;
//    }
//
//    //计算出校验码所在数组的位置
//    NSInteger idCardMod=idCardWiSum%11;
//    //得到最后一位身份证号码
//    NSString *idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
//    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
//    if(idCardMod==2) {
//        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
//            return NO;
//        }
//    }
//    else{
//        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
//            return NO;
//        }
//    }
//    return YES;
}

+ (NSString *)bookTextFormat:(NSString *)formatText{
    NSString *result = [formatText stringByReplacingOccurrencesOfString:@"/" withString:@"\\"];
    return result;
}


+ (BOOL)isCompositionWithNumbersAndLetters:(NSString *)string
{
    NSString * regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}



+ (UIViewController *)getCurrentNaC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


+ (NSString *)urlString:(NSString *)paramsString{
    NSString *str1 = [paramsString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"{" withString:@"/"];
    NSString *str5 = [str4 stringByReplacingOccurrencesOfString:@":" withString:@"/"];
    NSString *str6 = [str5 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    NSString *urlStr = [str6 stringByReplacingOccurrencesOfString:@"ID" withString:@"id"];
    return urlStr;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;
}


+ (NSString *)percentUrl:(NSString *)oriUrl {
    if (IOS_VERSION < 9) {
        if ([oriUrl isKindOfClass:[NSString class]]) {
            oriUrl = [oriUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    } else {
        if ([oriUrl isKindOfClass:[NSString class]]) {
            oriUrl = [oriUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
    }
    return oriUrl;
}

// 获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}



// 获取上一个viewController
+ (UIViewController *)obtainPreviousViewController{
    NSArray *VCarray = [self getCurrentVC].navigationController.childViewControllers;
    return VCarray[VCarray.count - 2];;
}

// 跳过某个控制器返回
+ (BOOL)jumpOverViewController:(NSString *)VcName{
    UINavigationController *naV = [DY_Common getCurrentVC].navigationController;
    NSArray *VCarray = naV.childViewControllers;
    for (int i = 0; i < VCarray.count; i++) {
        UIViewController *vc = VCarray[i];
        NSString *className = NSStringFromClass([vc class]);
        if ([VcName isEqualToString:className]) {
            UIViewController *backVC = VCarray[i-1];
            if (backVC) {
                [naV popToViewController:backVC animated:YES];
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)backOverViewController:(NSString *)VcName{
    UINavigationController *naV = [DY_Common getCurrentVC].navigationController;
    NSArray *VCarray = naV.childViewControllers;
    for (int i = 0; i < VCarray.count; i++) {
        UIViewController *vc = VCarray[i];
        NSString *className = NSStringFromClass([vc class]);
        if ([VcName isEqualToString:className]) {
            [naV popToViewController:vc animated:YES];
            return YES;
        }
    }
   return NO;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

+ (UIImage *)getQrCodeImageWithContent:(NSString *)content {
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    UIImage *img = [self createNonInterpolatedUIImageFormCIImage:image withSize:200];
    
    return img;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    //设置比例
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap（位图）;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

+ (CGSize)sizeWithAdjustWeightWithContent:(NSString *)contentStr
                                     font:(UIFont *)font
                        constrainedHeight:(float)height
{
    if (IOS_VERSION < 7)
    {
        //version < 7.0
        
        CGSize size = [contentStr sizeWithFont:font
                             constrainedToSize:CGSizeMake(MAXFLOAT, height)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    else
    {
        //version >= 7.0
        
        //Return the calculated size of the Label
        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{
                                                         NSFontAttributeName : font
                                                         }
                                               context:nil].size;
        //        size.width += 5;
        return size;
    }
    
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


/**
 设置图片大小

 @param img 需要修改的图片
 @param newSize 图片大小
 @return 指定大小的图片
 */
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//判断是否为整形：
static BOOL isPureInt (NSString* string){
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
static BOOL isPureFloat(NSString*string){
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
/// 取出字符串中的数字包括小数点,但是不保证是正确格式的数字
/// @param str 包含数字的字符串
+ (NSString *)getTheNumberOfTheString:(NSString *)str{
//    if (str.length) {
//        return @"";
//    }
    NSString *number;
    if (str.length) {
        NSMutableArray *numArray = [[NSMutableArray alloc]init];
        NSString *temp = nil;
        NSInteger len = 0;
        BOOL only = YES;
        //遍历取出是整型的数字保存到数组
        for (int i = 0; i < str.length; i++) {
            temp = [str substringWithRange:NSMakeRange(i, 1)];
            if (isPureInt (temp)==YES) {
                NSString *tempNum = nil;
                for (int j = i+1; j < str.length; j++) {
                    tempNum = [str substringWithRange:NSMakeRange(j, 1)];
                    if (isPureInt (tempNum)==YES) {
                        len = j;
                    }else if (only && [tempNum isEqualToString:@"."]){
                        only = NO;
                        len = j;
                    }else{
                        break;
                    }
                }
                //                [numArray addObject:temp];
                temp = [str substringWithRange:NSMakeRange(i, len - i+1)];
                return temp;
            }
        }
        number = [numArray componentsJoinedByString:@""];
    }
    return number;
}


/**
 给view指定的边加上圆角

 @param view 需要处理的view
 @param corners 边
 */
+ (void)addFillet:(UIView *)view corners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(5,5)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


/**
 真四舍五入

 @param price 值
 @return 四舍五入后的值
 */
+ (float)roundFloat:(float)price{
    return (floorf(price*100 + 0.5))/100;
}

/**
 计算两个时间的间隔(毫秒)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSTimeInterval)contrastTimeWithStartDate:(NSString *)start endDate:(NSString *)end
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:start];
    NSDate *endDate = [dateFormatter dateFromString:end];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}

/**
 计算两个时间的间隔(秒)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackSecondWithStartDate:(NSString *)start endDate:(NSString *)end
{
    NSTimeInterval time = [self contrastTimeWithStartDate:start endDate:end];
    NSInteger second;
    second=(NSInteger)time%60;
    return second;
}

/**
 计算两个时间的间隔(分)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackMinuteWithStartDate:(NSString *)start endDate:(NSString *)end
{
    NSTimeInterval time = [self contrastTimeWithStartDate:start endDate:end];
    NSInteger minute,second;
    second=(NSInteger)time%60;
    minute = (NSInteger)(time/60)%60;
    return minute;
}

/**
 计算两个时间的间隔(小时)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackHourWithStartDate:(NSString *)start endDate:(NSString *)end
{
    NSTimeInterval time = [self contrastTimeWithStartDate:start endDate:end];
    NSInteger minute,second,hour;
    second=(NSInteger)time%60;
    minute = (NSInteger)(time/60)%60;
    hour = (NSInteger)(time/3600)%24;
    return hour;
}

/**
 计算两个时间的间隔(天)
 
 @param start 开始时间
 @param end 结束时间
 @return 间隔时间
 */
+ (NSInteger)contrastTimeBackDayWithStartDate:(NSString *)start endDate:(NSString *)end
{
    NSTimeInterval time = [self contrastTimeWithStartDate:start endDate:end];
    NSInteger minute,second,hour,day;
    second=(NSInteger)time%60;
    minute = (NSInteger)(time/60)%60;
    hour = (NSInteger)(time/3600)%24;
    day = (time/3600/24);
    return day;
}

/*
 * 整形时间戳转换为datetime时间字符串
 */
+ (NSString *)time_timestampToString:(NSInteger)timestamp setDateFormatStr:(nullable NSString *)formatString{

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:formatString==nil?@"yyyy-MM-dd":formatString];

    NSString* string=[dateFormat stringFromDate:confromTimesp];

    return string;
}



/**
 裁切图片(变成圆形)

 @param image 需要裁切的图片
 @return 圆形图片
 */
+ (UIImage *)circleImageWithImg:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





/**
 金额格式处理

 @param string <#string description#>
 @return <#return value description#>
 */
+ (NSString *)formatDecimalNumber:(NSString *)string {
    if (!string || string.length == 0) {
        return string;
    }
    NSNumber *number = @([string doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //kCFNumberFormatterDecimalStyle
    formatter.numberStyle = NSNumberFormatterDecimalStyle;//NSNumberFormatterStyle
    formatter.positiveFormat = @"###,##0.00";
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}



+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

+ (NSString *)queryKeyChainIDByKey:(NSString *)keychainStr
{
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    return currentDeviceUUIDStr;
}

+ (void)saveKeyChainIDByKey:(NSString *)keychainStr
{
    if ([DY_Common queryKeyChainIDByKey:keychainStr]) {
        [SAMKeychain setPassword:[DY_Common queryKeyChainIDByKey:keychainStr] forService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    }
}

+ (NSString *)getDeviceIdWithKey:(NSString *)keychainStr
{
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"Save UUIDStr:%@",currentDeviceUUIDStr);
        [SAMKeychain setPassword:currentDeviceUUIDStr forService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    }
    NSLog(@"Load UUIDStr:%@",currentDeviceUUIDStr);
    return currentDeviceUUIDStr;
}

+ (NSString *)getChainString:(NSString *)chainStr withChainKey:(NSString *)chainKey
{
    NSString * currenChainValue= [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
    if ([DY_Common queryKeyChainIDByKey:chainKey]) {
        if (![currenChainValue isEqualToString:chainStr]) {
            [SAMKeychain setPassword:chainStr forService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
        }
        currenChainValue= [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
    }else{
        [SAMKeychain setPassword:chainStr forService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
        currenChainValue= [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
    }
    return currenChainValue;
}

+ (void)createChainString:(NSString *)chainStr withChainKey:(NSString *)chainKey
{
    if (chainStr != nil || ![chainStr isEqualToString:@""])
    {
        [SAMKeychain setPassword:chainStr forService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:chainKey];
    }
}

+ (void)deleteKeyChainWithKey:(NSString *)keychainStr
{
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    if (currentDeviceUUIDStr)
    {
        [SAMKeychain deletePasswordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    }
}

+ (void)deleteDeviceIdWithKey:(NSString *)keychainStr
{
    NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    if (currentDeviceUUIDStr)
    {
        [SAMKeychain deletePasswordForService:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] account:keychainStr];
    }
}


#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

/**
 获取缓存大小
 
 @return 缓存大小
 */
+ (NSString *)getCachesSize{
    // 调试
#ifdef DEBUG
    // 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
    // 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
    BOOL isDirectory = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
        [exception raise];
    }
    //发布
#else
#endif
    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSString *filePath = nil;
    long long totalSize = 0;
    for (NSString *subpath in subpathArray) {
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        totalSize += fileSize;
    }
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    if (totalSize > 1000 * 1000) {
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
    } else if (totalSize > 1000) {
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
    } else {
        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
    }
    return totalSizeString;
}

/**
 清除缓存
 */
+ (void)removeCache{
    
    // 1.拿到cachePath路径的下一级目录的子文件夹
    // contentsOfDirectoryAtPath:error:递归
    // subpathsAtPath:不递归
    
    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    
    // 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subpathArray.count == 0) {
        //        [SVProgressHUD showNOmessage:@"缓存已清理"];
        return ;
    }
    
    NSError *error = nil;
    NSString *filePath = nil;
    BOOL flag = NO;
    
    NSString *size = [self getCachesSize];
    
    for (NSString *subpath in subpathArray) {
        
        filePath = [cachePath stringByAppendingPathComponent:subpath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            // 删除子文件夹
            BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            
            if (isRemoveSuccessed) { // 删除成功
                
                flag = YES;
            }
        }
        
    }
    
    //    if (NO == flag)
    //        [SVProgressHUD showNOmessage:@"缓存已清理"];
    //    else
    //        [SVProgressHUD showYESmessage:[NSString stringWithFormat:@"为您腾出%@空间",size]];
    
    return ;
    
}

+(void)evaluateAppstoreScoresWithAppID:(NSString *)appId
{
//    NSString*urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8",appId];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];
    
    NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appId]];
    if ([[UIApplication sharedApplication] canOpenURL:appReviewUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:appReviewUrl];
        }
    }
}


+ (UILabel *)categoryLabelWithTitleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor{
    UILabel *lab = [[UILabel alloc]init];
    lab.font = kTextFont(10);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.layer.cornerRadius = RadiusIcon/2;
    lab.clipsToBounds = YES;
    lab.textColor = titleColor;
    lab.backgroundColor = bgColor;
    lab.layer.borderColor = titleColor.CGColor;
    lab.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    return lab;
}

+(NSArray *)randomArray:(NSArray *)arr
{
    //随机数从这里边产生
    NSMutableArray *startArray=[NSMutableArray arrayWithArray:arr];
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    for (int i=0; i<arr.count; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}


+(NSInteger)checkLimitConditionCurrentTime
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";//格式：yyyy-MM-dd-HH:mm:ss
    NSString *refDate = [formatDay stringFromDate:now];
    NSString *datecount = [refDate stringByReplacingOccurrencesOfString:@":" withString:@""];
    datecount = [datecount stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([datecount intValue]>[achievedTime3 intValue]) {
    
        return 4;
    }
    if ([datecount intValue]>[achievedTime2 intValue]) {
    
        return 3;
    }
    if ([datecount intValue]>[achievedTime1 intValue]) {
    
        return 2;
    }
    if ([datecount intValue]>[achievedTime0 intValue]) {
    
        return 1;
    }
    return 0;
}

// 拼接参数
+ (NSString *)getParams:(NSDictionary *)params {
    NSArray *keyAray = [params allKeys];
    NSMutableString *result = [NSMutableString string];
    for (NSString *obj in keyAray) {
        NSValue *value = [params objectForKey:obj];
        [result appendString:[NSString stringWithFormat:@"&%@=%@",obj,value]];
    }
//    if (result && result.length > 0) {
//        [result replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];//去除http第一个参数的&符号
//    }
    //    result = [@"date=20151031&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" mutableCopy];
    return result;
}


@end
