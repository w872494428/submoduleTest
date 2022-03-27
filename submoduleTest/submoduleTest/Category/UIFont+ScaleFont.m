//
//  UIFont+ScaleFont.m
//  MTReader
//
//  Created by mitu on 2021/8/3.
//

#import "UIFont+ScaleFont.h"
/** 是否是4.0屏幕*/
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/** 是否是4.7屏幕*/
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/** 是否是5.5屏幕*/
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#ifdef iPhone6
#define fontScale 1.0
#elif iPhone5
#define fontScale 0.8
#elif iPhone6plus
#define fontScale 1.2
#else
#define fontScale 0.7
#endif
#define displayFontSize(fontSize) fontSize * fontScale
@implementation NSObject (Extension)

+ (void)swizzleClassSelector:(SEL)originalSelector withSwizzledClassSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end

@implementation UIFont (ScaleFont)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassSelector:@selector(systemFontOfSize:) withSwizzledClassSelector:@selector(gy_systemFontOfSize:)];
        [self swizzleClassSelector:@selector(systemFontOfSize:weight:) withSwizzledClassSelector:@selector(gy_systemFontOfSize:weight:)];
        [self swizzleClassSelector:@selector(boldSystemFontOfSize:) withSwizzledClassSelector:@selector(gy_boldSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(italicSystemFontOfSize:) withSwizzledClassSelector:@selector(gy_italicSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(fontWithName:size:) withSwizzledClassSelector:@selector(gy_fontWithName:size:)];
    });
}

+ (UIFont *)gy_systemFontOfSize:(CGFloat)fontSize
{
    return [self gy_systemFontOfSize:displayFontSize(fontSize)];
}

+ (UIFont *)gy_systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight
{
    return [self gy_systemFontOfSize:displayFontSize(fontSize) weight:weight];
}


+ (UIFont *)gy_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [self gy_boldSystemFontOfSize:displayFontSize(fontSize)];
}

+ (UIFont *)gy_italicSystemFontOfSize:(CGFloat)fontSize
{
    return [self gy_italicSystemFontOfSize:displayFontSize(fontSize)];
}

+ (nullable UIFont *)gy_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    return [self gy_fontWithName:fontName size:displayFontSize(fontSize)];
}
@end
