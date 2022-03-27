//
//  UIFont+ScaleFont.h
//  MTReader
//
//  Created by mitu on 2021/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ScaleFont)
+ (UIFont *)gy_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)gy_systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight;
+ (UIFont *)gy_boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)gy_italicSystemFontOfSize:(CGFloat)fontSize;
+ (nullable UIFont *)gy_fontWithName:(NSString *)fontName size:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
