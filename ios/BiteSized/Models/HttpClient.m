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

@end
