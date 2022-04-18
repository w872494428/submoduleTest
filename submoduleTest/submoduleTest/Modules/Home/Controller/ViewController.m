//
//  ViewController.m
//  submoduleTest
//
//  Created by linqipeng on 2022/3/24.
//

#import "ViewController.h"
#import "WkWebviewController.h"
//#import <CocoaLumberjack/CocoaLumberjack.h>

//@import CocoaLumberjack;
//@import SPIndicator;
//@import BabyBluetooth;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *staticTextLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPlist];
//    BabyBluetooth * baby = BabyBluetooth.new;
    
    
    [DDLog addLogger:[DDOSLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling：时间回滚，0表示忽略时间回滚
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;

    [DDLog addLogger:fileLogger];
    DDLogInfo(@"提示信息"); // 默认是黑色
    DDLogError(@"错误信息"); // 红色
    DDLogWarn(@"警告"); // 橙色
    DDLogVerbose(@"详细信息"); // 默认是黑色
    
//    //获取log文件夹路径
//    NSString *logDirectory = [fileLogger.logFileManager logsDirectory];
//    DDLogDebug(@"%@", logDirectory);
}

#pragma mark - button action

- (IBAction)oneBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 1111 按钮";
}

- (IBAction)twoBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 2222 按钮";
    WkWebviewController *webVC=[[WkWebviewController alloc]init];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"intretech01.html" withExtension:nil];
    webVC.fileURL = fileURL;
//    webVC.boolNaviBarHeight=YES;
//    webVC.hidesBottomBarWhenPushed=YES;
//    webVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:webVC animated:YES completion:^{
            
    }];
}
- (IBAction)threeBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 3333 按钮";
}
- (IBAction)fourBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 4444 按钮";
}
- (IBAction)fiveBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 5555 按钮";
}
- (IBAction)sixBtnAction:(UIButton *)sender {
    self.staticTextLab.text = @"你点击了 6666 按钮";
}


#pragma mark - 网络请求
+ (void)networkRequestWithAPI:(NSString *)api requestMethod:(NSString *)method cachePolicy:(NSURLRequestCachePolicy)cachePolicy requestParamer:(NSDictionary *)paramer Completion:(void(^)(NSDictionary * _Nullable result, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    
    ///设置请求url 和 缓存方式 和 超时时间
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:api] cachePolicy:cachePolicy timeoutInterval:30];
    ///设置请求方式
    [request setHTTPMethod:method];
    ///设置内容格式
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    ///设置请求参数
    NSError *error = nil;
    NSData *paramerData = [NSJSONSerialization dataWithJSONObject:paramer options:NSJSONWritingPrettyPrinted error:&error];
    if (error == nil) {
        [request setHTTPBody:paramerData];
    }
    ///开始请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data) {
            ///json化数据
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ///返回请求结果
            !completion?:completion(result, response, nil);
        } else {
            !completion?:completion(nil, nil, error);
        }
    }];
    
    [dataTask resume];
}


- (NSString *)md5HexDigest:(NSString*)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH * 2];
    CC_MD5( cStr,(unsigned int)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}


#pragma mark 读取plist文件的内容
- (void)loadPlist
{
    //1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"About" withExtension:@"plist"];
    
    //2.获取数据
    NSArray *_data = [NSArray arrayWithContentsOfURL:url];
    NSLog(@"_data=%@",_data);
    
}

- (void)performanceExample {
    NSInteger index = 0;
    for (NSInteger i =0 ; i < 10000000; ++i) {
        index++;
    }
}



- (void)dealloc {
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
