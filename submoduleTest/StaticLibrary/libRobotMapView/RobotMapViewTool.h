//
//  RobotMapViewTool.h
//  RobotMapView
//
//  Created by linqipeng on 2022/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RobotMapViewTool : NSObject
+ (instancetype)sharedInstance;

- (id)creatMapview;
- (void)removeMapview;
- (void)hidden;
- (void)show;
@end

NS_ASSUME_NONNULL_END
