//
//  WkWebviewController.m
//  ETTwallet
//
//  Created by chinbin on 2021/1/7.
//  Copyright © 2021 chinbin. All rights reserved.
//

#import "WkWebviewController.h"
#import <WebKit/WebKit.h>
#import "DY_Common.h"

@interface WkWebviewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) WKWebView *  webView;
@property (nonatomic, strong) UILabel *navbartitle;
//网页加载进度视图
@property (nonatomic, strong) UIProgressView * progressView;

@end

@implementation WkWebviewController
- (NSMutableDictionary *)param
{
    if (!_param) {
        self.param = [NSMutableDictionary dictionary];
    }
    return _param;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=_boolNaviBarHeight?NO:YES;
    
    //发起信息需求
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getToken"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getStatusBarHeight"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goLiveList"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goLiveRoom"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goAddress"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getAddress"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"backAppLiveView"];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getToken"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getStatusBarHeight"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goLiveList"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goLiveRoom"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goAddress"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getAddress"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"backAppLiveView"];
}
#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_boolNaviBarHeight) {
        
        //导航栏 navbar
        UIImage *image = [UIImage new];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

        [self.navigationController.navigationBar setTranslucent:YES];
        //    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
        //    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
        if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
            {
            [self.navigationController.navigationBar setShadowImage:image];
        }
        [self.navigationController.navigationBar setBarTintColor:kBlueUIColor];
        self.view.backgroundColor=kBlueUIColor;
        // 后退按钮
        UIButton * goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //    goBackButton.backgroundColor = [UIColor whiteColor];
        if ([_colorType isEqualToString:@"gray"]) {
            [goBackButton setImage:[UIImage imageNamed:@"icon_back_deepgray"] forState:UIControlStateNormal];
        }else{
            [goBackButton setImage:[UIImage imageNamed:@"icon_back_default"] forState:UIControlStateNormal];
//            [goBackButton setImage:[UIImage imageNamed:@"icon_back_deepgray"] forState:UIControlStateNormal];
        }
        [goBackButton addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
        goBackButton.frame = CGRectMake(0, 0, 30, 64);
        UIBarButtonItem * goBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:goBackButton];
        self.navigationItem.leftBarButtonItems = @[goBackButtonItem];
        
        // 导航栏标题
        self.navigationItem.titleView = self.navbartitle;
//        self.navbartitle.textColor=kDeepGrayUIColor;
        [self.view addSubview:self.webView];
        
    }else{
        [self.view addSubview:self.webView];
    }
    
    
    
    // 拼接参数
    NSString *dataStr = [DY_Common getParams:_param];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",self.urlStr,dataStr];
    NSURL * loadUrl = _fileURL?_fileURL:[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loadUrl];
    [self.webView loadRequest:request];
//    [self.view addSubview:self.progressView];//不添加jindutiao
    //添加监测网页加载进度的观察者
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
}

#pragma mark - Event Handle
- (void)goBackAction:(id)sender
{
    self.progressView.hidden = YES;
    
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//H5返回
- (void)goBack
{
    self.progressView.hidden = YES;
    
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - KVO
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {

        NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.webView.estimatedProgress == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }
    else if
    ([keyPath isEqualToString:@"title"] && object == _webView){
        NSLog(@"self.navbartitle=%@",_webView.title);
        self.navbartitle.text = _boolNaviBarHeight?_webView.title:@"";//如果有导航栏时，不显示标题
//        self.navigationItem.title = _webView.title;//设置导航栏标题
        if ([_webView.title isEqualToString:@"transparent"])
        {
            self.navigationController.navigationBarHidden = YES;
            
        }
        else
        {
            self.navigationController.navigationBarHidden = NO;
            
            
        }
        
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}


#pragma mark - Getter
- (UIProgressView *)progressView {
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64 , self.view.frame.size.width, 2)];
        
        _progressView.tintColor =[_colorType isEqualToString:@"gray"]?[UIColor grayColor]:UIColor.whiteColor;
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
- (WKWebView *)webView{
    if(_webView == nil){
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        if (@available(iOS 10.0, *)) {
            config.mediaTypesRequiringUserActionForPlayback = YES;
        } else {
            // Fallback on earlier versions
        }
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
//        __weak typeof(self)weakSelf = self;
//        [wkUController addScriptMessageHandler:weakSelf  name:@"getToken"];
        config.userContentController = wkUController;
        
        //以下代码适配文本大小
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        //如果有导航栏时，设置_webView向下偏移一个导航栏高度
        if (_boolNaviBarHeight==NO) {
            _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -20, KSCREENW, KSCREENH-64) configuration:config];
        }else{
            _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, KSCREENW, KSCREENH-64) configuration:config];
        }
        
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

/**getEvaluateBridgeSettings
 *具体实现流程就是ios设置localstorage，传递距离顶部的值，然后我用js获取该值，然后设置css的顶部高度
 *
 */
- (void)getEvaluateBridgeSettings{
    //设置token等头信息
//    SingleObject * usersing = [SingleObject getInstance];
//
//    NSString * userContent = [NSString stringWithFormat:
//                              @"{\"token\": \"%@\",\"paddingTop\": \"%f\",\"uid\": \"%@\",\"avatar_url\": \"%@\"}", TokenStr,STATUS_BAR_HEIGHT,usersing.user_id,usersing.avatar_url];
//    // 设置localStorage
//    NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('userContent', '%@')", userContent];
//    // 移除localStorage
//    // NSString *jsString = @"localStorage.removeItem('userContent')";
//    // 获取localStorage
//    // NSString *jsString = @"localStorage.getItem('userContent')";
//    [self.webView evaluateJavaScript:jsString completionHandler:nil];
    
    
}

//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"name:%@\\\\n body:%@\\\\n",message.name,message.body);

    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    NSLog(@"----%@",parameter);
    //JS调用OC
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        
    }
    if ([message.name isEqualToString:@"backAppLiveView"]) {
        NSLog(@"backAppLiveView");
        NSString *b = [NSString stringWithFormat:@"%@",message.body];;
        if (![b isEqualToString:@"b"]) {
            NSString *inputValueJS = [NSString stringWithFormat:@"backAppLiveView('%@')",@"a"];
            [self.webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                        //打印如果error为null，表示已调通
                        NSLog(@"value: %@ error: %@", response, error);
                        NSLog(@"backAppLiveView");
            //             [self.navigationController popViewControllerAnimated:YES];
               }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if ([message.name isEqualToString:@"getStatusBarHeight"]) {
        NSLog(@"getStatusBarHeight");
        CGFloat BarHeight = 20 * 2;
        if ([UIScreen mainScreen].bounds.size.height == 736 ||  [UIScreen mainScreen].bounds.size.height == 812 ) {
            BarHeight = 20 * 3;
        }
           //给js传值，获取用户信息
        NSString *inputValueJS = [NSString stringWithFormat:@"getStatusBarHeight('%f')",BarHeight];
            [self.webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    //打印如果error为null， 表示已调通
                    NSLog(@"value: %@ error: %@", response, error);
                    NSLog(@"错误:%@", error.localizedDescription);
            }];
    }
//    NSLog(@"parameter[name]=%@",parameter[@"name"]);
//    if([parameter[@"name"] isEqualToString:@"gd_onBack"]){
//        [self goBack];
//    }
}

#pragma mark - WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    
    [self.view bringSubviewToFront:self.progressView];
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self getEvaluateBridgeSettings];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    

}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
    
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark - WKUIDelegate

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)dealloc{
    //移除注册的js方法
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"NativeModel"];
    //移除观察者
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    UIEdgeInsets insets = self.view.safeAreaInsets;
    self.progressView.frame = CGRectMake(-20, insets.top , self.view.frame.size.width, 2);
}

-(UILabel *)navbartitle
{
    if (!_navbartitle) {
        _navbartitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREENW-60*2, 44)];
        _navbartitle.textAlignment = NSTextAlignmentCenter;
        _navbartitle.textColor = UIColor.whiteColor;
    }
    return _navbartitle;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
