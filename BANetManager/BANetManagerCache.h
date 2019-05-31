#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BANetManagerCache : NSObject
+ (void)ba_setHttpCache:(id)httpData
              urlString:(NSString *)urlString
             parameters:(NSDictionary *)parameters;
+ (id)ba_httpCacheWithUrlString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters;
+ (void)ba_httpCacheWithUrlString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters block:(void(^)(id <NSCoding> responseObject))block;
+ (NSString *)ba_cacheWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters;
+ (CGFloat)ba_getAllHttpCacheSize;
+ (void)ba_clearAllHttpCache;
@end
