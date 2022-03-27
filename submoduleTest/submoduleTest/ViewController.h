//
//  ViewController.h
//  submoduleTest
//
//  Created by linqipeng on 2022/3/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (NSString *)md5HexDigest:(NSString*)input;


- (void)performanceExample;




////网络请求
+ (void)networkRequestWithAPI:(NSString *)api requestMethod:(NSString *)method cachePolicy:(NSURLRequestCachePolicy)cachePolicy requestParamer:(NSDictionary *)paramer Completion:(void(^)(NSDictionary * _Nullable result, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;

@end

