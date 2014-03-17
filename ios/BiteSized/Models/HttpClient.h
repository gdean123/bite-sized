#import <Foundation/Foundation.h>

@protocol SimpleURLSession;

@interface HttpClient : NSObject

- (id)initWithSession:(id<SimpleURLSession>)urlSession;
- (void)getList:(NSString *)url
           then:(void(^)(NSArray *list))successHandler
          error:(void (^)(NSError *error))errorHandler;

@end
