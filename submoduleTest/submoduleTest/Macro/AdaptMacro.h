//
//  AdaptMacro.h
//  MTReader
//
//  Created by mitu on 2021/7/23.
//

#ifndef AdaptMacro_h
#define AdaptMacro_h


//获取系统对象
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kAppDelegateObj         ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// Device设备
#define KFrameW self.view.frame.size.width
#define KFrameH self.view.frame.size.height
#define KSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KSCREENH [[UIScreen mainScreen] bounds].size.height
#define KSCREENW [[UIScreen mainScreen] bounds].size.width


#define LY_iPhoneX  (((int)((KSCREENH/KSCREENW)*100) == 216)?YES:NO)
#define LY_StatusBarHeight                 (LY_iPhoneX ? 44.f : 20.f)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height              //状态栏
#define LY_NavigationBarHeight             44.f
#define LY_TabbarHeight                    (LY_iPhoneX ? (49.f+34.f) : 49.f)
#define LY_TabbarSafeBottomMargin          (LY_iPhoneX ? 34.f : 0.f)
#define LY_StatusBarAndNavigationBarHeight (LY_iPhoneX ? 88.f : 64.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (LY_iPhoneX ? 34.f : 0.f)

///设备机型
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

// 判断iPhoneX系列
#define LL_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// 是否为IPad
// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define kIsIPad ([[[UIDevice currentDevice] model] isEqual: @"iPad"]?1:0)


#define kAdjustRatio(num) (ceil((KSCREENW/(kIsIPad?768.0:375.0))*(num)))
#define SET_FIX_SIZE_WIDTH (KSCREENH /(750/2.0))
//宽度适配
#define AdaptScale(w) (w) * SET_FIX_SIZE_WIDTH
#define AdaptWidth375(w) (((w) / 375.0) * KSCREENH)
#define AS375(w) (w) * SET_FIX_SIZE_WIDTH
#define AW375(w) (((w) / 375.0) * KSCREENH)
#define AH667(H) (((H) / 667.0) * KSCREENH)
#define FontSize(w) (((w) / 375.0) * KSCREENH)


// iOS系统
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS13 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0)
#define iOS12 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)
#define iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define iOS102 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.2)
#define iOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS6 ((([[UIDevice currentDevice].systemVersion intValue] >= 6) && ([[UIDevice currentDevice].systemVersion intValue] < 7)) ? YES : NO )
#define iOS5 ((([[UIDevice currentDevice].systemVersion intValue] >= 5) && ([[UIDevice currentDevice].systemVersion intValue] < 6)) ? YES : NO )
//判断是否是iphone机型，区分ios13.0系统机型识别

// iPhone
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
  #define IS_IPHONE  [[UIDevice currentDevice].model isEqualToString:@"iPhone"]
#else
  #define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#endif

//5 区分真机模拟器的时候务必用TARGET_IPHONE_SIMULATOR来判断
/*
 TARGET_IPHONE_SIMULATOR和TARGET_OS_IPHONE 是苹果的两个宏定义，
 在真机sdk中位于ios->usr/include/targetconditionals.h中，
 在模拟器sdk中位于simulator->usr/include/targetconditionals.h中
 
 模拟器sdk中的定义：
 #define TARGET_OS_IPHONE            1
 #define TARGET_IPHONE_SIMULATOR     1
 
 真机sdk中的定义：
 
 #define TARGET_OS_IPHONE            1
 #define TARGET_IPHONE_SIMULATOR     0
 */
#if TARGET_IPHONE_SIMULATOR//模拟器
#define SIMULATOR 1
#elif TARGET_OS_IPHONE//真机
#define SIMULATOR 0
#endif


//宏定义if条件语句
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
  //初始化提示框；
  #define SHOW_ALERT(_msg_)  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:_msg_ preferredStyle:  UIAlertControllerStyleAlert];\
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { \
  }]]; \
  [self presentViewController:alert animated:true completion:nil];
#else
  //alert弹窗
  #define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
  [alert show];
#endif

#endif /* AdaptMacro_h */
