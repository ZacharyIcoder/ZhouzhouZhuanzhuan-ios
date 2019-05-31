#import "BANetManagerCache.h"
#import "YYCache.h"
static NSString * const kBANetManagerCache = @"BANetManagerCache";
static  YYCache *_dataCache;
@implementation BANetManagerCache
+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:kBANetManagerCache];
}
+ (void)ba_setHttpCache:(id)httpData
              urlString:(NSString *)urlString
             parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self ba_cacheWithUrlString:urlString parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey];
}
+ (id)ba_httpCacheWithUrlString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self ba_cacheWithUrlString:urlString parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}
+ (void)ba_httpCacheWithUrlString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters block:(void(^)(id <NSCoding> responseObject))block
{
    NSString *cacheKey = [self ba_cacheWithUrlString:urlString parameters:parameters];
    [_dataCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(object);
        });
    }];
}
+ (NSString *)ba_cacheWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
{
    if (!parameters)
    {
        return urlString;
    }
    NSData *cacheData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *cacheString = [[NSString alloc] initWithData:cacheData encoding:NSUTF8StringEncoding];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", urlString, cacheString];
    return cacheKey;
}
+ (CGFloat)ba_getAllHttpCacheSize
{
    return [_dataCache.diskCache totalCost]/1024.0/1024.0;
}
+ (void)ba_clearAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}
@end
