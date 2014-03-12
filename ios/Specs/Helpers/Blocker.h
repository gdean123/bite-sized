#import <Foundation/Foundation.h>

@interface Blocker : NSObject

- (void)wait;
- (void)doneWaiting;

@end
