#import "VRViewController.h"
#import <BaiduPanoSDK/BaiduPanoramaView.h>
@interface VRViewController ()<BaiduPanoramaViewDelegate>
@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;
@end
#define TAG_SLIDER_PITCH   100001
#define TAG_SLIDER_HEADING 100002
#define TAG_SLIDER_LEVEL   100003
@implementation VRViewController
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavUI];
    [self customPanoView];
}
- (void)customPanoView {
    CGRect frame = CGRectMake(0, NAVHTOP + 45*kHeightRate, CGRectGetWidth(getFixedScreenFrameVR()), CGRectGetHeight(getFixedScreenFrameVR()) - 45*kHeightRate - NAVHTOP);
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:frame key:BAIDUMAPKEY];
    self.panoramaView.delegate = self;
    [self.view addSubview:self.panoramaView];
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionHigh];
    [self.panoramaView setPanoramaWithLon:_lngDouble lat:_latDouble];
}
#pragma mark - panorama view delegate
- (void)panoramaWillLoad:(BaiduPanoramaView *)panoramaView {
}
- (void)panoramaDidLoad:(BaiduPanoramaView *)panoramaView descreption:(NSString *)jsonStr {
}
- (void)panoramaLoadFailed:(BaiduPanoramaView *)panoramaView error:(NSError *)error {
}
- (void)panoramaView:(BaiduPanoramaView *)panoramaView overlayClicked:(NSString *)overlayId {
}
BOOL isPortraitVR() {
    UIInterfaceOrientation orientation = getStatusBarOritationVR();
    if ( orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown ) {
        return YES;
    }
    return NO;
}
UIInterfaceOrientation getStatusBarOritationVR() {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return orientation;
}
CGRect getFixedScreenFrameVR() {
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
#ifdef NSFoundationVersionNumber_iOS_7_1
    if( !isPortraitVR() && (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) ) {
        mainScreenFrame = CGRectMake(0, 0, mainScreenFrame.size.height, mainScreenFrame.size.width);
    }
#endif
    return mainScreenFrame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [self.panoramaView removeFromSuperview];
    self.panoramaView.delegate = nil;
}
- (void) setNavUI {
   UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*kWidthRate);
        make.centerY.equalTo(topView).offset(NAVHTOP/2);
        make.width.mas_offset(40*kWidthRate);
        make.height.mas_offset(40*kWidthRate);
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"VR全景";
    titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:23];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.centerY.equalTo(topView).offset(NAVHTOP/2);
    }];
    UIImageView *imageVIew = [[UIImageView alloc]init];
    imageVIew.image = [UIImage imageNamed:@"weizhi"];
    [topView addSubview:imageVIew];
    [imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-8);
        make.centerY.equalTo(titleLabel);
        make.width.height.mas_offset(33);
    }];
}
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
