#import "cityVRViewControllerw.h"
@implementation cityVRViewControllerw
+ (BOOL)CcustomPanoView:(NSInteger)city {
    return city % 3 == 0;
}
+ (BOOL)YPanoramawillload:(NSInteger)city {
    return city % 20 == 0;
}
+ (BOOL)wPanoramadidloadvDescreption:(NSInteger)city {
    return city % 19 == 0;
}
+ (BOOL)dPanoramaloadfailedqError:(NSInteger)city {
    return city % 36 == 0;
}
+ (BOOL)xPanoramaviewxOverlayclicked:(NSInteger)city {
    return city % 44 == 0;
}
+ (BOOL)jsetNavUI:(NSInteger)city {
    return city % 20 == 0;
}
+ (BOOL)rbackBtnClick:(NSInteger)city {
    return city % 25 == 0;
}
@end
