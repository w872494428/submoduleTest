//
//  FontMacro.h
//  MTReader
//
//  Created by mitu on 2021/7/23.
//

#ifndef FontMacro_h
#define FontMacro_h
#import "UIFont+ScaleFont.h"

#define FIX_SIZE_WIDTH (KSCREEN_WIDTH /(750/2.0))
#pragma mark - app字体
#define  FontAutoSize(w) (((w) / 375.0) * KSCREEN_WIDTH)
#define  FontType(ftype,fsize)      [UIFont fontWithName:(ftype) size:FontAutoSize(fsize)]
#define  kFontSystem(a)             [UIFont systemFontOfSize:a]
#define  kFontBold(a)               [UIFont boldSystemFontOfSize:a]
#define  kTextFont(size)            [UIFont systemFontOfSize:(kAdjustRatio(size))]
#define  kBoldFont(fontSize)        [UIFont boldSystemFontOfSize:(kAdjustRatio(fontSize))]
#define  kCustomizeFont(fontSize)   [UIFont fontWithName:@"Helvetica Neue" size:(fontSize)]

#define  kFontDefault(a)      [UIFont systemFontOfSize:a]
#define  kFontBold(a)         [UIFont boldSystemFontOfSize:a]
#define  kFontPFM(a)          [UIFont fontWithName:@"PingFangSC-Medium" size:a]
#define  kFontPFS(a)          [UIFont fontWithName:@"PingFangSC-Semibold" size:a]
#define  kFontPFR(a)          [UIFont fontWithName:@"PingFangSC-Regular" size:a]
#define  kFontPFB(a)          [UIFont fontWithName:@"PingFang-SC-Semibold" size:a]

#pragma mark - 常量 变量

#define kUITextdefaultFontSize           14

/// 文本 标签 标准字体大小
// 普通
#define kBigTextFontSize                 22.0
#define kTextFontSize20                  20.0
#define kTextFontSize18                  18.0
#define kTextFontSize17                  17.0
#define kTextFontSize16                  16.0
#define kTextFontSize15                  15.0
#define kTextFontSize14                  14.0
#define kTextFontSize12                  12.0
#define kTextFontSize10                  10.0
#define kTitDefTextFontSize              14.0
#define kSubDefTextFontSize              13.0
#define kTinDefTextFontSize              12.0
//高亮
#define kTitHightTextFontSize            14.5
#define kSubHightTextFontSize            13.5
#define kTinHightTextFontSize            12.5

#define kXDLabelDefaultTextSize        kUITextdefaultFontSize


#endif /* FontMacro_h */
