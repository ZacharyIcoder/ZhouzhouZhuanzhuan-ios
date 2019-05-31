#import "DetailViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <UIKit/UIKit.h>
#import "VRViewController.h"
#import "DetailCell.h"
#import "cityVRViewControllerw.h"
#import "BNRoutePlanModel.h"
#import "BNaviService.h"
#import "BNaviModel.h"
#import "BNUtility.h"
static NSString *annotationViewIdentifier = @"com.Baidu.BMKWalkingRouteSearch";
@interface DetailViewController ()<BMKMapViewDelegate,BMKLocationManagerDelegate,BMKRouteSearchDelegate,UITableViewDelegate,UITableViewDataSource,BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKUserLocation *userLocation; 
@property (nonatomic, strong) BMKLocationManager *locationManager; 
@property (nonatomic, strong) BMKRouteSearch *walkingRouteSearch;
@property (nonatomic,strong) UITableView *tableview;
@end
@implementation DetailViewController
{
    UIView *topView;
    NSDictionary *mainDic;
    NSArray *titleArr;
    NSArray *titleImageArr;
    BOOL isfirstInView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"  %@",_keyDic);
    isfirstInView = NO;
    [self setNavUI];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 45*kHeightRate + NAVHTOP, KUIScreenWidth, 230*kHeightRate)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.baseIndoorMapEnabled = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.zoomLevel = 17;
    [self.view addSubview:_mapView];
    [self setUserloParas];
    [self startLocation];
    [self configUI];
    [self getDeatilDta];
    [self configScrollview];
    [cityVRViewControllerw dPanoramaloadfailedqError:12];
    [cityVRViewControllerw rbackBtnClick:11];
    CLLocationCoordinate2D wgs84llCoordinate = [BNaviService_Location getLastLocation].coordinate;
    CLLocationCoordinate2D bd09McCoordinate;
    bd09McCoordinate = [BNUtility convertToBD09MCWithWGS84ll:wgs84llCoordinate];
}
- (void) setUserloParas {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.isAccuracyCircleShow = NO;
    param.accuracyCircleStrokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    param.accuracyCircleFillColor = [UIColor colorWithRed:79/255.0 green:214.0/255.0 blue:0 alpha:0.2];
    param.locationViewImage = [UIImage imageNamed:@"map_image"];
    [self.mapView updateLocationViewWithParam:param];
}
- (void) startLocation {
    _locationManager = [[BMKLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    _locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = NO;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
    [_locationManager startUpdatingLocation];
    [_locationManager startUpdatingHeading];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}
- (void) setNavUI {
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 45*kHeightRate + NAVHTOP)];
    topView.backgroundColor = KUIColorFontColor_Hong;
    [self.view addSubview:topView];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*kWidthRate, NAVHTOP+3*kHeightRate, 30*kWidthRate, 40*kWidthRate)];
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:backBtn];
    UILabel *titleLabel = [[UILabel alloc]init];
    NSString *titleStr;
    if (_keyStr.length >= 12) {
        NSRange range = NSMakeRange(0, 10);
        titleStr = [NSString stringWithFormat:@"%@..",[_keyStr substringWithRange:range]];
    }else{
        titleStr = _keyStr;
    }
    titleLabel.text = titleStr;
    titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:23];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->topView);
        make.centerY.equalTo(self->topView).offset(NAVHTOP/2);
    }];
}
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    if (!heading) {
        return;
    }
    if (!self.userLocation) {
        self.userLocation = [[BMKUserLocation alloc] init];
    }
    self.userLocation.heading = heading;
    [self.mapView updateLocationData:self.userLocation];
}
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (!location) {
        return;
    }
    if (!self.userLocation) {
        self.userLocation = [[BMKUserLocation alloc] init];
    }
    self.userLocation.location = location.location;
    [self.mapView updateLocationData:self.userLocation];
    if (!isfirstInView) {
        isfirstInView = YES;
        [self luxianBtnClick];
    }
}
- (void) configUI {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self->_mapView.mas_bottom);
        make.height.mas_offset(44*kHeightRate);
    }];
    UIButton *luxianBtn = [[UIButton alloc]init];
    [luxianBtn setImage:[UIImage imageNamed:@"daohang-1"] forState:(UIControlStateNormal)];
    [luxianBtn addTarget:self action:@selector(daohang) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:luxianBtn];
    [luxianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15*kWidthRate);
        make.top.equalTo(view);
        make.height.with.mas_offset(44*kHeightRate);
    }];
    UIButton *fenxiangBtn = [[UIButton alloc]init];
    [fenxiangBtn setImage:[UIImage imageNamed:@"fenxiang3"] forState:(UIControlStateNormal)];
    [fenxiangBtn addTarget:self action:@selector(fenxiangBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:fenxiangBtn];
    [fenxiangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(view);
        make.height.with.mas_offset(44*kHeightRate);
    }];
    UIButton *quanjingBtn = [[UIButton alloc]init];
    [quanjingBtn setImage:[UIImage imageNamed:@"vrquanjing"] forState:(UIControlStateNormal)];
    [quanjingBtn addTarget:self action:@selector(quanjingBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:quanjingBtn];
    [quanjingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15*kWidthRate);
        make.top.equalTo(view);
        make.height.with.mas_offset(44*kHeightRate);
    }];
}
- (void) fenxiangBtnClick {
    [self shareAction];
}
- (void) quanjingBtnClick {
    NSDictionary *loDic = _keyDic[@"location"];
    double lat = [loDic[@"lat"] doubleValue];
    double lng = [loDic[@"lng"] doubleValue];
    VRViewController *vc = [[VRViewController alloc]init];
    vc.latDouble = lat;
    vc.lngDouble = lng;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) daohang {
    [EasyTextView showText:@"首次加载导航会比较慢,请您耐心等待"];
    [self realNavi];
}
- (void) luxianBtnClick {
    BMKRouteSearch *routeSearch = [[BMKRouteSearch alloc] init];
    routeSearch.delegate = self;
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    start.name = @"我";
    start.pt = self.userLocation.location.coordinate;
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    end.name = _keyDic[@"title"];
    NSDictionary *loDic = _keyDic[@"location"];
    double lat = [loDic[@"lat"] doubleValue];
    double lng = [loDic[@"lng"] doubleValue];
    CLLocationCoordinate2D  clo2d = CLLocationCoordinate2DMake(lat, lng);
    end.pt = clo2d;
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    BOOL flag = [routeSearch walkingSearch:walkingRouteSearchOption];
    if (flag) {
        NSLog(@"步行路线规划检索发送成功");
    } else{
        NSLog(@"步行路线规划检索发送失败");
    }
}
- (void)setupDefaultData {
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    start.name = @"我";
    start.pt = self.userLocation.location.coordinate;
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    end.name = _keyDic[@"title"];
    NSDictionary *loDic = _keyDic[@"location"];
    double lat = [loDic[@"lat"] doubleValue];
    double lng = [loDic[@"lng"] doubleValue];
    CLLocationCoordinate2D  clo2d = CLLocationCoordinate2DMake(lat, lng);
    end.pt = clo2d;
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    [self searchData:walkingRoutePlanOption];
}
- (void)searchData:(BMKWalkingRoutePlanOption *)option {
    _walkingRouteSearch = [[BMKRouteSearch alloc]init];
    _walkingRouteSearch.delegate = self;
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = option.from.pt;
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    end.pt = option.to.pt;
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    BOOL flag = [_walkingRouteSearch walkingSearch:walkingRoutePlanOption];
    if (flag) {
        NSLog(@"步行检索成功");
    } else{
        NSLog(@"步行检索失败");
    }
}
#pragma mark - BMKRouteSearchDelegate
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];
    if (error == BMK_SEARCH_NO_ERROR) {
        __block NSUInteger pointCount = 0;
        BMKWalkingRouteLine *routeline = (BMKWalkingRouteLine *)result.routes.firstObject;
        [routeline.steps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BMKWalkingStep *step = routeline.steps[idx];
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            annotation.coordinate = step.entrace.location;
            annotation.title = step.entraceInstruction;
            [_mapView addAnnotation:annotation];
            pointCount += step.pointsCount;
        }];
        BMKMapPoint *points =  new BMKMapPoint[pointCount];
        __block NSUInteger j = 0;
        [routeline.steps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BMKWalkingStep *step = routeline.steps[idx];
            for (NSUInteger i = 0; i < step.pointsCount; i ++) {
                points[j].x = step.points[i].x;
                points[j].y = step.points[i].y;
                j ++;
            }
        }];
        BMKPolyline *polyline = [BMKPolyline polylineWithPoints:points count:pointCount];
        [_mapView addOverlay:polyline];
        [self mapViewFitPolyline:polyline withMapView:self.mapView];
    }
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
            NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mapapi.bundle"]];
            NSString *file = [[bundle resourcePath] stringByAppendingPathComponent:@"images/icon_nav_bus"];
            annotationView.image = [UIImage imageWithContentsOfFile:file];
        }
        return annotationView;
    }
    return nil;
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 2.0;
        return polylineView;
    }
    return nil;
}
- (void)mapViewFitPolyline:(BMKPolyline *)polyline withMapView:(BMKMapView *)mapView {
    double leftTop_x, leftTop_y, rightBottom_x, rightBottom_y;
    if (polyline.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyline.points[0];
    leftTop_x = pt.x;
    leftTop_y = pt.y;
    rightBottom_x = pt.x;
    rightBottom_y = pt.y;
    for (int i = 1; i < polyline.pointCount; i++) {
        BMKMapPoint point = polyline.points[i];
        if (point.x < leftTop_x) {
            leftTop_x = point.x;
        }
        if (point.x > rightBottom_x) {
            rightBottom_x = point.x;
        }
        if (point.y < leftTop_y) {
            leftTop_y = point.y;
        }
        if (point.y > rightBottom_y) {
            rightBottom_y = point.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTop_x , leftTop_y);
    rect.size = BMKMapSizeMake(rightBottom_x - leftTop_x, rightBottom_y - leftTop_y);
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 10, 20, 10);
    [mapView fitVisibleMapRect:rect edgePadding:padding withAnimated:YES];
}
- (void) getDeatilDta {
    NSString *urlS = [NSString stringWithFormat:@"http://api.map.baidu.com/place/v2/detail?uid=%@&output=json&scope=2&ak=%@",_keyDic[@"uid"],BAIDUWEBKEY];
    [RequestModel GetRequestWithUrl:urlS andParams:nil responseHandler:^(NSDictionary * _Nullable resultDict) {
        mainDic = resultDict[@"result"];
        NSLog(@"  %@",resultDict);
        [_tableview reloadData];
    }];
}
- (void) configScrollview {
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 42*kHeightRate + 250*kHeightRate + 44*kHeightRate, KUIScreenWidth, KUIScreenHeight - (40*kHeightRate + 250*kHeightRate + 44*kHeightRate))];
    _tableview.backgroundColor = KUIColorFontColor_LV;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[DetailCell class] forCellReuseIdentifier:@"cell00"];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    titleArr = @[@"地址:",@"营业时间:",@"联系电话:"];
    titleImageArr = @[@"dizhi",@"yingyeshijian",@"lianxidianhua"];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArr.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48*kHeightRate;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell00";
    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageview.image = [UIImage imageNamed:titleImageArr[indexPath.row]];
    cell.titleLabel.text = titleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.contentLabel.text = mainDic[@"address"];
    }else if (indexPath.row == 1){
        NSString *str = mainDic[@"detail_info"][@"shop_hours"];
        if (str.length != 0) {
            cell.contentLabel.text = str;
        }else{
            cell.contentLabel.text = @"暂无数据";
        }
    }else{
        NSString *str = mainDic[@"telephone"];
        if (str.length != 0) {
            cell.contentLabel.text = str;
        }else{
            cell.contentLabel.text = @"暂无数据";
        }
    }
    return cell;
}
#pragma mark ---------- 分享 ----------
-(void)shareAction{
    NSString *textToShare = _keyStr;
    NSURL *urlToShare = [NSURL URLWithString:_keyDic[@"detail_info"][@"detail_url"]];
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    if (@available(iOS 9.0, *)) {
        activityVC.excludedActivityTypes = @[UIActivityTypePostToTwitter,UIActivityTypePostToFacebook,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypeAirDrop,UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeOpenInIBooks,];
    } else {
    }
    [self presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
        } else  {
            NSLog(@"cancled");
        }
    };
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        NSString *str = mainDic[@"telephone"];
        if (str.length != 0) {
          [self iponeTel:str andIpone:str];
        }else{
        }
    }
}
-(void)iponeTel:(NSString *)telGet andIpone :(NSString *)ipone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"拨打该电话按照正常资费由运营商收取：%@",telGet] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",ipone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
    }];
}
- (BOOL)checkServicesInited
{
    if(![BNaviService_Instance isServicesInited])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"引擎尚未初始化完成，请稍后再试"
                                                           delegate:nil
                                                  cancelButtonTitle:@"我知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}
- (void)realNavi
{
    if (![self checkServicesInited]) return;
    [self startNavi];
}
- (void)startNavi
{
    BOOL useMyLocation = NO;
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    CLLocation *myLocation = [BNaviService_Location getLastLocation];
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    if (useMyLocation) {
        startNode.pos.x = myLocation.coordinate.longitude;
        startNode.pos.y = myLocation.coordinate.latitude;
        startNode.pos.eType = BNCoordinate_OriginalGPS;
    }
    else {
        startNode.pos.x = self.userLocation.location.coordinate.longitude;
        startNode.pos.y = self.userLocation.location.coordinate.latitude;
        startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    }
    [nodesArray addObject:startNode];
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    double xP = [_keyDic[@"location"][@"lng"] doubleValue];
    double yP = [_keyDic[@"location"][@"lat"] doubleValue];
    endNode.pos.x = xP;
    endNode.pos.y = yP;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    endNode.title = _keyStr;
    endNode.uid = _keyDic[@"uid"];
    [nodesArray addObject:endNode];
    [BNaviService_RoutePlan setDisableOpenUrl:YES];
    [BNaviService_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}
#pragma mark - BNNaviRoutePlanDelegate
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    [BNaviService_UI showPage:BNaviUI_NormalNavi delegate:self extParams:nil];
}
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary*)userInfo
{
    switch ([error code]%10000)
    {
        case BNAVI_ROUTEPLAN_ERROR_LOCATIONFAILED:
            NSLog(@"暂时无法获取您的位置,请稍后重试");
            break;
        case BNAVI_ROUTEPLAN_ERROR_ROUTEPLANFAILED:
            NSLog(@"无法发起导航");
            break;
        case BNAVI_ROUTEPLAN_ERROR_LOCATIONSERVICECLOSED:
            NSLog(@"定位服务未开启,请到系统设置中打开定位服务。");
            break;
        case BNAVI_ROUTEPLAN_ERROR_NODESTOONEAR:
            NSLog(@"起终点距离起终点太近");
            break;
        default:
            NSLog(@"算路失败");
            break;
    }
}
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}
#pragma mark - 安静退出导航
- (void)exitNaviUI
{
    [BNaviService_UI exitPage:EN_BNavi_ExitTopVC animated:YES extraInfo:nil];
}
#pragma mark - BNNaviUIManagerDelegate
- (void)onExitPage:(BNaviUIType)pageType  extraInfo:(NSDictionary*)extraInfo
{
    if (pageType == BNaviUI_NormalNavi)
    {
        NSLog(@"退出导航");
    }
    else if (pageType == BNaviUI_Declaration)
    {
        NSLog(@"退出导航声明页面");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(id)naviPresentedViewController {
    return self;
}
@end
