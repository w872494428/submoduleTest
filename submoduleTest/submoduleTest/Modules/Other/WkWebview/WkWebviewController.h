//
//  WkWebviewController.h
//  ETTwallet
//
//  Created by chinbin on 2021/1/7.
//  Copyright © 2021 chinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WkWebviewController : UIViewController
@property(nonatomic,copy)NSString *colorType;
@property(copy,nonatomic)NSString * urlStr;
@property(strong,nonatomic)NSURL *fileURL;
@property(strong,nonatomic)NSMutableDictionary * param;

/**说明：
 *boolNaviBarHeight=yes表示有导航栏。
 *如果有导航栏时，设置_webView向下偏移一个导航栏高度
 *如果有导航栏时，不显示标题有信息
 */
@property (nonatomic,assign) BOOL boolNaviBarHeight;
@end

NS_ASSUME_NONNULL_END
