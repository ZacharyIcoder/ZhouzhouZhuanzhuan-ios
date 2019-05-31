#import "MyWebViewController.h"
@interface MyWebViewController ()
@end
@implementation MyWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavUI];
    [self configUI];
}
- (void) configUI {
    UIWebView *webVIew = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVHTOP + 45*kHeightRate, KUIScreenWidth, KUIScreenHeight)];
    webVIew.backgroundColor = [UIColor redColor];
    [self.view addSubview:webVIew];
}
- (void) setNavUI {
    UIView *  topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"隐私政策";
    titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:23];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.centerY.equalTo(topView).offset(NAVHTOP/2);
    }];
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(15);
        make.centerY.equalTo(titleLabel);
        make.width.height.mas_offset(35);
    }];
}
- (void) backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
