#import "FakeURLSession.h"

@implementation FakeURLSession

- (void)completeGetWith:(NSString *)responseJson {
    NSData *responseData = [responseJson dataUsingEncoding:NSUTF8StringEncoding];
    self.completionHandler(responseData, nil, nil);
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                        completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    self.completionHandler = completionHandler;
    return nil;
}

@end
