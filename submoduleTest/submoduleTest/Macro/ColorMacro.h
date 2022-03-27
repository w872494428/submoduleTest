//
//  ColorMacro.h
//  MTReader
//
//  Created by mitu on 2021/7/23.
//

#ifndef ColorMacro_h
#define ColorMacro_h
#import "UIColor+Hex.h"

#define HexColor(value) [UIColor colorWithHexString:value]

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:1.f]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:(a)]

#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
                                             green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
                                              blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
                                             alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
                                            green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
                                             blue:((float)(v & 0x0000FF))/255.0 \
                                            alpha:a]


/*
 HexColor(@"#3177FF") //全局通用蓝色调
 */

#pragma mark  主题颜色
#define kThemeColor                          UIColor.whiteColor   //控制器主题背景色
#define kMainColor                           HexColor(@"#3177FF")
#define kThemeCoverColor                     RGB(229, 232, 245) //主题背景蒙版（搜索主页背景）
#define kThemeTextBlueColor                  HexColor(@"#3177FF") //文字主题色
#define kThemeBtnBackColor                   HexColor(@"#3177FF") //按钮主题背景色
#define kThemeLabBackColor                   HexColor(@"#3177FF") //按钮主题背景色
#define kThemeBoarderColor                   HexColor(@"#3177FF") //按钮主题背景色
#define kTextFieldCoverColor                 HexColor(@"#F5F5F5")
#define kTitleTextColor                      HexColor(@"#222222")
#define kButtonTextColor                     HexColor(@"#666666")
#define kTextPlaceholderColor                HexColor(@"#666666") //文本输入框的背景颜色
#define kNavBarColor RGB(218, 31, 2)
#define kTabBarColor RGB(79, 170, 241) 
#define kTableBackColor UIColor.whiteColor
#define kHintBackColor      HexColor(@"#D8D8D8")  //提示窗背景颜色
#define STModalWindowDefaultBackgroundColor [UIColor colorWithWhite:0 alpha:0.55] // 蒙版颜色
#define UITableViewSeparatorColor  [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1.0] // 分割线颜色
#define kSeparatorLineColor       [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1] // 分割线颜色#E5E5E5
#define UnderBottomLineColor       HexColor(@"#3177FF")

//系统基色
#define kClearColor         [UIColor clearColor]  //透明调
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]
#define kRandomFlatColor    [UIColor randomFlatColor]

//参考调色
#define kGreenUIColor            HexColor(@"#00AF87")  //绿色调
#define kBlueUIColor             HexColor(@"#256EBD")  //蓝色调
#define kPurpleUIColor           HexColor(@"#FF9F05")  //橙色调
#define kOrangeUIColor           HexColor(@"#CB05B4")  //紫色调
#define kDarkGrayUIColor         HexColor(@"#3F4657")  //暗灰调
#define kHintBackColor           HexColor(@"#D8D8D8")  //提示窗背景颜色
#define kTinyGrayUIColor         HexColor(@"#D0D0D0")  //微灰调
#define kLightGrayUIColor        HexColor(@"#9F9F9F")  //轻灰调
#define kPlaceholederColor       HexColor(@"#9F9F9F")  //轻灰调
#define kDeepGrayUIColor         HexColor(@"#707070")  //深灰调
#define kDeepDarkColor           HexColor(@"#051F3B")  //暗色调
#define kDeepTitleColor          HexColor(@"#676767")  //深灰调
#define kbtnGrayColor            HexColor(@"#8D8D8D")  //灰色背景(按钮灰背景)
#define kWhiteUIColor            HexColor(@"#FFFFFF")  //纯白色
#define kTinyWhiteColor          HexColor(@"#F2F2F2")  //微白色
#define kWhite090Color           HexColor(@"#FAFAFA")  //90%白色
#define kWhite080Color           HexColor(@"#D3E2F2")  //80%白色

#pragma mark  文字颜色
#define kReadTextColor1 RGB(51,51,51)
#define kReadTextColor2 RGB(52,67,48)
#define kReadTextColor3 RGB(60,71,82)
#define kReadTextColor4 RGB(112,47,39)
#define kReadTextColor5 RGB(139,141,144)
#define kReadTextColor6 RGB(143,142,138)
#define kReadTextColor7 RGB(127,146,170)
#pragma mark  阅读背景颜色
#define kReadViewBgColor1 RGB(247,247,247)
#define kReadViewBgColor2 RGB(218,232,216)
#define kReadViewBgColor3 RGB(208,221,236)
#define kReadViewBgColor5 RGB(60,65,69)
#define kReadViewBgColor6 RGB(56,52,49)
#define kReadViewBgColor7 RGB(14,14,14)

#define kDeputyColor RGB(173, 216, 230) // (155, 238, 211)
#endif /* ColorMacro_h */
