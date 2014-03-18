#import "HttpClient.h"
#import "SimpleURLSession.h"

@interface HttpClient ()

@property (strong, nonatomic) id<SimpleURLSession> urlSession;

@end

@implementation HttpClient

- (id)initWithSession:(id<SimpleURLSession>)urlSession {
    self = [super init];

    if (self) {
        self.urlSession = urlSession;
    }

    return self;
}

- (void)getList:(NSString *)url
           then:(void(^)(NSArray *list))successHandler
          error:(void (^)(NSError *error))errorHandler {
    [[self.urlSession dataTaskWithURL:[NSURL URLWithString:url]
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        successHandler(responseArray);
                    }] resume];
}

- (void)post:(NSString *)url
    withBody:(NSDictionary *)body
        then:(void (^)(NSDictionary *dictionary))successHandler
       error:(void (^)(NSError *error))errorHandler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    NSString *postBody = [self createPostParams:body];
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    [[self.urlSession dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            successHandler(dictionary);
                        }] resume];
}

- (void)delete:(NSString *)url
          then:(void (^)())successHandler
         error:(void (^)(NSError *error))errorHandler {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"DELETE";

    [[self.urlSession dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            successHandler();
                        }] resume];
}

#pragma mark -- Private

- (NSString *)createPostParams:(NSDictionary *)body {
    NSMutableArray *keyValueArray = [[NSMutableArray alloc] init];

    for (NSString *key in body) {
        NSString *value = [body objectForKey:key];
        [keyValueArray addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }

    return [keyValueArray componentsJoinedByString:@"&"];
}

@end
