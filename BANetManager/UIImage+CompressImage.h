#import <UIKit/UIKit.h>
typedef UIImage JPEGImage;
typedef UIImage PNGImage;
typedef NSData JPEGData;
typedef NSData PNGData;
@interface UIImage (CompressImage)
+ (JPEGImage *)needCompressImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale;
+ (JPEGImage *)needCompressImageData:(NSData *)imageData size:(CGSize )size scale:(CGFloat )scale;
+ (JPEGImage *)needCenterImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale;
+ (JPEGImage *)jpegImageWithPNGImage:(PNGImage *)pngImage;
+ (JPEGImage *)jpegImageWithPNGData:(PNGData *)pngData;
+ (JPEGData *)jpegDataWithPNGData:(PNGData *)pngData;
+ (JPEGData *)jpegDataWithPNGImage:(PNGImage *)pngImage;
@end
