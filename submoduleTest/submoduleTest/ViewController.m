//
//  ViewController.m
//  submoduleTest
//
//  Created by linqipeng on 2022/3/24.
//

#import "ViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

//@import CocoaLumberjack;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DDLog addLogger:[DDOSLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;

    [DDLog addLogger:fileLogger];

}


@end
