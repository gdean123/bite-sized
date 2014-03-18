#import <Foundation/Foundation.h>
#import "SimpleURLSession.h"

@interface FakeURLSession : NSObject <SimpleURLSession>

@property (nonatomic, copy) void (^completionHandler)(NSData *data, NSURLResponse *response, NSError *error);
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *body;

- (void)completeGetWith:(NSString *)responseJson;
- (void)completePostWith:(NSString *)responseJson;
- (void)completeDelete;

@end
