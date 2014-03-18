#import <Foundation/Foundation.h>

@protocol SimpleURLSession;

@interface HttpClient : NSObject

- (id)initWithSession:(id<SimpleURLSession>)urlSession;

- (void)getList:(NSString *)url
           then:(void (^)(NSArray *list))successHandler
          error:(void (^)(NSError *error))errorHandler;

- (void)post:(NSString *)url
    withBody:(NSDictionary *)body
        then:(void (^)(NSDictionary *dictionary))successHandler
       error:(void (^)(NSError *error))errorHandler;

- (void)delete:(NSString *)url
          then:(void (^)())successHandler
         error:(void (^)(NSError *error))errorHandler;

@end
