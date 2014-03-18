#import "FakeURLSession.h"

@implementation FakeURLSession

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                        completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    self.url = [url absoluteString];
    self.completionHandler = completionHandler;
    return nil;
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    self.url = [request.URL absoluteString];
    self.method = request.HTTPMethod;
    self.body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    self.completionHandler = completionHandler;
    return nil;
}

- (void)completeGetWith:(NSString *)responseJson {
    NSData *responseData = [responseJson dataUsingEncoding:NSUTF8StringEncoding];
    self.completionHandler(responseData, nil, nil);
}

- (void)completePostWith:(NSString *)responseJson {
    NSData *responseData = [responseJson dataUsingEncoding:NSUTF8StringEncoding];
    self.completionHandler(responseData, nil, nil);
}

- (void)completeDelete {
    self.completionHandler(nil, nil, nil);
}

@end
