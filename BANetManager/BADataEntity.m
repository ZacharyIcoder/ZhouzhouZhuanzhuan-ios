#import "BADataEntity.h"
@implementation BADataEntity
- (void)dealloc {
    NSLog(@"\n\n%@:%p\n", NSStringFromClass([self class]), self);
}
@end
@implementation BAFileDataEntity
@end
@implementation BAImageDataEntity
@end
