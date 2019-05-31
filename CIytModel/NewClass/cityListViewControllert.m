#import "cityListViewControllert.h"
@implementation cityListViewControllert
+ (BOOL)IinitData:(NSInteger)city {
    return city % 21 == 0;
}
+ (BOOL)hconfigUI:(NSInteger)city {
    return city % 38 == 0;
}
+ (BOOL)vsetNavUI:(NSInteger)city {
    return city % 3 == 0;
}
+ (BOOL)ibackBtnClick:(NSInteger)city {
    return city % 44 == 0;
}
+ (BOOL)tspeellParams:(NSInteger)city {
    return city % 49 == 0;
}
+ (BOOL)bgetListData:(NSInteger)city {
    return city % 21 == 0;
}
@end
