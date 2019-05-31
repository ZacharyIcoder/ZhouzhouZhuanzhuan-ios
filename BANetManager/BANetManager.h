#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define BANetManagerShare [BANetManager sharedBANetManager]
#define BAWeak  __weak __typeof(self) weakSelf = self
#define BANetManagerDeprecated(instead) __deprecated_msg(instead)
typedef NS_ENUM(NSUInteger, BANetworkStatus)
{
    BANetworkStatusUnknown           = 0,
    BANetworkStatusNotReachable,
    BANetworkStatusReachableViaWWAN,
    BANetworkStatusReachableViaWiFi
};
typedef NS_ENUM(NSUInteger, BAHttpRequestType)
{
    BAHttpRequestTypeGet = 0,
    BAHttpRequestTypePost,
    BAHttpRequestTypePut,
    BAHttpRequestTypeDelete
};
typedef NS_ENUM(NSUInteger, BAHttpRequestSerializer) {
    BAHttpRequestSerializerJSON,
    BAHttpRequestSerializerHTTP,
};
typedef NS_ENUM(NSUInteger, BAHttpResponseSerializer) {
    BAHttpResponseSerializerJSON,
    BAHttpResponseSerializerHTTP,
};
typedef void(^BANetworkStatusBlock)(BANetworkStatus status);
typedef void( ^ BAResponseSuccessBlock)(id response);
typedef void( ^ BAResponseFailBlock)(NSError *error);
typedef void( ^ BAUploadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);
typedef void( ^ BADownloadProgressBlock)(int64_t bytesProgress,
int64_t totalBytesProgress);
typedef NSURLSessionTask BAURLSessionTask;
@class BADataEntity;
@interface BANetManager : NSObject
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) BAHttpRequestSerializer requestSerializer;
@property (nonatomic, assign) BAHttpResponseSerializer responseSerializer;
@property(nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;
+ (instancetype)sharedBANetManager;
#pragma mark - 网络请求的类方法 --- get / post / put / delete
+ (BAURLSessionTask *)ba_request_GETWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                  failureBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BADownloadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_request_POSTWithEntity:(BADataEntity *)entity
                                   successBlock:(BAResponseSuccessBlock)successBlock
                                   failureBlock:(BAResponseFailBlock)failureBlock
                                  progressBlock:(BADownloadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_request_PUTWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                  failureBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BADownloadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_request_DELETEWithEntity:(BADataEntity *)entity
                                     successBlock:(BAResponseSuccessBlock)successBlock
                                     failureBlock:(BAResponseFailBlock)failureBlock
                                    progressBlock:(BADownloadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_uploadImageWithEntity:(BADataEntity *)entity
                                  successBlock:(BAResponseSuccessBlock)successBlock
                                   failurBlock:(BAResponseFailBlock)failureBlock
                                 progressBlock:(BAUploadProgressBlock)progressBlock;
+ (void)ba_uploadVideoWithEntity:(BADataEntity *)entity
                    successBlock:(BAResponseSuccessBlock)successBlock
                    failureBlock:(BAResponseFailBlock)failureBlock
                   progressBlock:(BAUploadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_downLoadFileWithEntity:(BADataEntity *)entity
                                   successBlock:(BAResponseSuccessBlock)successBlock
                                   failureBlock:(BAResponseFailBlock)failureBlock
                                  progressBlock:(BADownloadProgressBlock)progressBlock;
+ (BAURLSessionTask *)ba_uploadFileWithWithEntity:(BADataEntity *)entity
                                     successBlock:(BAResponseSuccessBlock)successBlock
                                     failureBlock:(BAResponseFailBlock)failureBlock
                                    progressBlock:(BAUploadProgressBlock)progressBlock;
#pragma mark - 网络状态监测
+ (void)ba_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus;
#pragma mark - 自定义请求头
+ (void)ba_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey;
+ (void)ba_clearAuthorizationHeader;
#pragma mark - 取消 Http 请求
+ (void)ba_cancelAllRequest;
+ (void)ba_cancelRequestWithURL:(NSString *)URL;
- (void)ba_clearAllHttpCache;
@end
#pragma mark - 过期方法 网络请求的类方法 --- get / post / put / delete
