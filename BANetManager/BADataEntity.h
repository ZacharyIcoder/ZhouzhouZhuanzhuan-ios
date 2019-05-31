#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface BADataEntity : NSObject
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) id parameters;
@property (nonatomic, assign, getter=isNeedCache) BOOL needCache;
@end
@interface BAFileDataEntity : BADataEntity
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;
@end
@interface BAImageDataEntity : BADataEntity
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray<NSString *> *fileNames;
@property (nonatomic, copy) NSString *imageType;
@property (nonatomic, assign) CGFloat imageScale;
@end
