#import "HomeViewController.h"
#import "HomeCCell.h"
#import "ListViewController.h"
#import "ShezhiViewController.h"
#import <CoreLocation/CoreLocation.h>
static CGFloat topGap = 10;
static CGFloat leftGap = 10;
static CGFloat bottomGap = 10;
static CGFloat rightGap = 10;
static CGFloat lineSpace = 10.f;
static CGFloat InteritemSpace = 10.f;
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface HomeViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
    @property (nonatomic,strong) UIScrollView *scrollview;
    @property (nonatomic,copy) NSMutableArray *dibiaoArr;
    @property (nonatomic,copy) NSMutableArray *dibiaoTitleArr;
    @property (nonatomic,copy) NSMutableArray *dibiaoImageArr;
@property (nonatomic,copy) CLLocation *locationS;
    @property (nonatomic, strong) UICollectionView * collectionView;
    @property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@end
#define topheight 45*kHeightRate + NAVHTOP
@implementation HomeViewController{
    UIView *topView;
}
- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addLongPress];
    [self initData];
    [self startLocation];
}
- (void) setNavUI {
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"All Around Me";
    titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:23];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->topView);
        make.centerY.equalTo(self->topView).offset(NAVHTOP/2);
    }];
    UIImageView *imageVIew = [[UIImageView alloc]init];
    imageVIew.image = [UIImage imageNamed:@"weizhi"];
    [topView addSubview:imageVIew];
    [imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-8);
        make.centerY.equalTo(titleLabel);
        make.width.height.mas_offset(33);
    }];
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"shezhi2"] forState:(UIControlStateNormal)];
    [setBtn addTarget:self action:@selector(shezhiBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->topView).offset(-15);
        make.centerY.equalTo(titleLabel);
        make.width.height.mas_offset(35);
    }];
}
- (void) shezhiBtnClick {
    ShezhiViewController *vc = [[ShezhiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) configUI{
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topheight, KUIScreenWidth, KUIScreenHeight - TABBARDIBU - topheight)];
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(0, KUIScreenHeight);
    [self.view addSubview:_scrollview];
}
    - (void) initData {
        _dibiaoArr=[[NSMutableArray alloc]initWithObjects:@"便利店",@"超市",@"宠物店",@"大学",@"蛋糕店",@"电视台",@"电玩场",@"电影院",@"飞机场",@"服装店",@"公园",@"海洋馆",@"汉堡店",@"火车站",@"火锅店",@"加油站",@"健身房",@"警察局",@"酒吧",@"咖啡馆",@"烤串",@"理发店",@"丽人馆",@"轮渡",@"面馆",@"披萨",@"书店",@"水果店",@"体育馆",@"图书馆",@"网吧",@"维修店",@"西餐",@"洗衣店",@"鞋店",@"学校",@"药店",@"医院",@"银行",@"中餐",@"珠宝", nil];
        _dibiaoTitleArr=[[NSMutableArray alloc]initWithObjects:@"便利店",@"超市",@"宠物店",@"大学",@"蛋糕店",@"电视台",@"电玩场",@"电影院",@"飞机场",@"服装店",@"公园",@"海洋馆",@"汉堡店",@"火车站",@"火锅店",@"加油站",@"健身房",@"警察局",@"酒吧",@"咖啡馆",@"烤串",@"理发店",@"丽人馆",@"轮渡",@"面馆",@"披萨",@"书店",@"水果店",@"体育馆",@"图书馆",@"网吧",@"维修店",@"西餐",@"洗衣店",@"鞋店",@"学校",@"药店",@"医院",@"银行",@"中餐",@"珠宝", nil];
        _dibiaoImageArr=[[NSMutableArray alloc]initWithObjects:@"便利店",@"超市",@"宠物店",@"大学",@"蛋糕店",@"电视台",@"电玩场",@"电影院",@"飞机场",@"服装店",@"公园",@"海洋馆",@"汉堡店",@"火车站",@"火锅店",@"加油站",@"健身房",@"警察局",@"酒吧",@"咖啡馆",@"烤串",@"理发店",@"丽人馆",@"轮渡",@"面馆",@"披萨",@"书店",@"水果店",@"体育馆",@"图书馆",@"网吧",@"维修店",@"西餐",@"洗衣店",@"鞋店",@"学校",@"药店",@"医院",@"银行",@"中餐",@"珠宝", nil];
        [self.collectionView reloadData];
    }
#pragma mark ************* touch event *************
- (void)cutDirection
    {
        if (self.layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else {
            self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        [self.collectionView reloadData];
    }
- (void)longPress:(UILongPressGestureRecognizer *)gesture
    {
        CGPoint point = [gesture locationInView:_collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan:
            {
                if (!indexPath) {
                    break;
                }
                [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
            case UIGestureRecognizerStateChanged:
            {
                [_collectionView updateInteractiveMovementTargetPosition:point];
            }
            break;
            case UIGestureRecognizerStateEnded:
            {
                [_collectionView endInteractiveMovement];
            }
            break;
            default:
            {
                [_collectionView cancelInteractiveMovement];
            }
            break;
        }
    }
#pragma mark ************* collectionView data *************
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
    {
        return self.dibiaoArr.count;
    }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        HomeCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell00" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.titleLabel.text = _dibiaoTitleArr[indexPath.row];
        cell.imageview.image = [UIImage imageNamed:_dibiaoImageArr[indexPath.row]];
        return cell;
    }
#pragma mark ************* collectionView delegate *************
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
    {
        return YES;
    }
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
    {
        id content = self.dibiaoArr[sourceIndexPath.item];
        [self.dibiaoArr removeObjectAtIndex:sourceIndexPath.item];
        [self.dibiaoArr insertObject:content atIndex:destinationIndexPath.item];
        id contentX = self.dibiaoTitleArr[sourceIndexPath.item];
        [self.dibiaoTitleArr removeObjectAtIndex:sourceIndexPath.item];
        [self.dibiaoTitleArr insertObject:contentX atIndex:destinationIndexPath.item];
        id contentP = self.dibiaoImageArr[sourceIndexPath.item];
        [self.dibiaoImageArr removeObjectAtIndex:sourceIndexPath.item];
        [self.dibiaoImageArr insertObject:contentP atIndex:destinationIndexPath.item];
    }
#pragma mark ************* private method *************
- (void)addLongPress
    {
        UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        press.minimumPressDuration = 0.3;
        [self.collectionView addGestureRecognizer:press];
    }
#pragma mark ************* lazy load *************
- (UICollectionView *)collectionView
    {
        if (!_collectionView) {
            self.layout = [[UICollectionViewFlowLayout alloc]init];
            self.layout.minimumLineSpacing = lineSpace;
            self.layout.minimumInteritemSpacing = InteritemSpace;
            self.layout.itemSize = CGSizeMake(floorf((kWidth - leftGap - rightGap - InteritemSpace * 2) / 3), (kWidth - leftGap - rightGap) / 3 + 30);
            self.layout.sectionInset = UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44, kWidth, kHeight - [UIApplication sharedApplication].statusBarFrame.size.height - 44) collectionViewLayout:self.layout];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[HomeCCell class] forCellWithReuseIdentifier:@"cell00"];
            _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.view addSubview:_collectionView];
        }
        return _collectionView;
    }
    - (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        NSString *str = _dibiaoArr[indexPath.row];
        NSLog(@"da");
        ListViewController *vc = [[ListViewController alloc]init];
        if (_locationS) {
            NSString *str = [NSString stringWithFormat:@"%f,%f",_locationS.coordinate.latitude,_locationS.coordinate.longitude];
            vc.locationStr = str;
        }
        vc.keyName = str;
        [self.navigationController pushViewController:vc animated:YES];
    }
#pragma mark - 定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"111");
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    _locationS = newLocation;
    NSLog(@"  %f   %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    [manager stopUpdatingLocation];
}
@end
