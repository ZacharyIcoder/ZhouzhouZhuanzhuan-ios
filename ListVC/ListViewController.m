#import "ListViewController.h"
#import "ListCell.h"
#import "DetailViewController.h"
#import "cityListViewControllert.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentnum;
}
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *tableView;
@end
@implementation ListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavUI];
    [self configUI];
    [self initData];
    [self getListData];
    [cityListViewControllert hconfigUI:12];
    [cityListViewControllert tspeellParams:1233];
}
- (void) initData {
    currentnum = 1;
    _dataArr = [[NSMutableArray alloc]init];
}
- (void) configUI {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45*kHeightRate + NAVHTOP, KUIScreenWidth, KUIScreenHeight - 45*kHeightRate - NAVHTOP) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ListCell class] forCellReuseIdentifier:@"cell00"];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self->currentnum ++;
        [self getListData];
    }];
    [self.view addSubview:_tableView];
}
- (void) setNavUI {
    UIView *  topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = _keyName;
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
- (NSDictionary *) speellParams {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_keyName forKey:@"query"];
    [dic setObject:_locationStr forKey:@"location"];
    [dic setObject:@"2000" forKey:@"radius"];
    [dic setObject:@"2" forKey:@"scope"];
    [dic setObject:@"10" forKey:@"page_size"];
    [dic setObject:[NSString stringWithFormat:@"%d",currentnum] forKey:@"page_num"];
    return dic;
}
- (void) getListData {
    [_tableView.mj_footer endRefreshing];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.map.baidu.com/place/v2/search?output=json&ak=%@",BAIDUWEBKEY];
    NSDictionary *param = [self speellParams];
    [RequestModel GetRequestWithUrl:urlStr andParams:param responseHandler:^(NSDictionary * _Nullable resultDict) {
        [self->_tableView.mj_footer endRefreshing];
        NSLog(@"  %@",resultDict);
        if ([resultDict[@"status"] integerValue] == 0) {
            NSArray *arr = resultDict[@"results"];
            if (arr.count <= 0) {
                [self->_tableView.mj_footer setState:(MJRefreshStateNoMoreData) ];
                if (self->_dataArr.count == 0) {
                    [EasyTextView showErrorText:@"您附近没有你所需的场所哟!"];
                }else{
                    [EasyTextView showErrorText:@"您附近所有的内容都搜索完啦!"];
                }
            }else{
                [self->_dataArr addObjectsFromArray:resultDict[@"results"]];
                [self->_tableView reloadData];
            }
        }else{
            [EasyTextView showErrorText:@"非常抱歉,当前访问人数过多,请稍会访问!"];
        }
    }];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100*kHeightRate;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell00";
    ListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = _dataArr[indexPath.row];
    [cell setData:dic];
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *vc = [[DetailViewController alloc]init];
    NSDictionary *dic = _dataArr[indexPath.row];
    vc.keyStr = dic[@"name"];
    vc.keyDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
