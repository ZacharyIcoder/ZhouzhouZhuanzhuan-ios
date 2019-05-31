#import "BaseViewController.h"
#define KUIColorFont KUIColorFontColor_Hei
@interface BaseViewController ()<UIGestureRecognizerDelegate>
    @property(nonatomic,assign)BOOL isCanSideBack;
    @end
@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor blackColor],
      NSFontAttributeName:[UIFont systemFontOfSize:17]};
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ---------- 边缘滑动bug ----------
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanSideBack;
}
-(void)forbiddenSideBack{
    self.isCanSideBack=NO;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}
- (void)resetSideBack {
    self.isCanSideBack=YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self forbiddenSideBack];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self resetSideBack];
}
    @end
