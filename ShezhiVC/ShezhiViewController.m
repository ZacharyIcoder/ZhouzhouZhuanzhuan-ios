#import "ShezhiViewController.h"
#import "ShezhiCell.h"
#import "MyWebViewController.h"
#import "cityShezhiViewControllerA.h"
@interface ShezhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@end
@implementation ShezhiViewController
{
    NSArray *titleArr;
    NSArray *iamgeArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KUIColorFontColor_LV;
    titleArr = @[@"评分",@"隐私政策"];
    iamgeArr = @[@"pingfen",@"yinsiX"];
    [self configUI];
    [self setNavUI];
    [cityShezhiViewControllerA EBackbtnclickcity:12];
    [cityShezhiViewControllerA tConfiguicity:13];
}
- (void) configUI {
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVHTOP + 45*kHeightRate, KUIScreenWidth, KUIScreenHeight - NAVHTOP - 45*kHeightRate) style:(UITableViewStylePlain)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerClass:[ShezhiCell class] forCellReuseIdentifier:@"cell00"];
    [self.view addSubview:_tableview];
}
- (void) setNavUI {
    UIView *  topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"设置";
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
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*kHeightRate;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell00";
    ShezhiCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[ShezhiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageview.image = [UIImage imageNamed:iamgeArr[indexPath.row]];
    cell.titleLabel.text = titleArr[indexPath.row];
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", @"123456"]]];
    }else{
        MyWebViewController *vc = [[MyWebViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
