//
//  YXCustomButton.h
//  LoLoGo
//
//  Created by chinbin on 2022/1/6.
//  Copyright © 2022 LoLoRobo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YXCustomButton;

typedef void (^YYCusButtonClick)(YXCustomButton *btn);
@interface YXCustomButton : UIButton
@property (nonatomic, copy) YYCusButtonClick clickEvent;
@property (nonatomic, strong) UILabel * innerLabel;
@property (nonatomic, strong) UILabel * titleLab;
@property (assign, nonatomic) CGFloat fontValue;
@property (assign, nonatomic) CGFloat gestureScale;

@property (assign, nonatomic) BOOL isEnlarge;//表示按钮是否选中状态，并不知道按钮选中时候显示的是大灰还是大蓝色
@property (assign, nonatomic) BOOL isAddTarget;//标记是大灰还是大蓝,用于判断是否开启——进行目标点的增删,默认YES表示当前目标点是开启状态
@end

NS_ASSUME_NONNULL_END
