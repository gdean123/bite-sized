#import <Foundation/Foundation.h>
#import "SimpleURLSession.h"

@interface FakeURLSession : NSObject <SimpleURLSession>

@property (nonatomic, copy) void (^completionHandler)(NSData *data, NSURLResponse *response, NSError *error);

- (void)completeGetWith:(NSString *)responseJson;

@end
