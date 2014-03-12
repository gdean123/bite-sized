#import "Blocker.h"

@interface Blocker ()

@property(assign, nonatomic) BOOL isWaiting;

@end

@implementation Blocker

- (id)init {
    self = [super init];
    if (self) {
        self.isWaiting = YES;
    }

    return self;
}

- (void)wait {
    while (self.isWaiting && [self runMainLoopTemporarily]) {}
    self.isWaiting = YES;
}

- (void)doneWaiting {
    self.isWaiting = NO;
}

- (BOOL)runMainLoopTemporarily {
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:.1];
    return [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:loopUntil];
}

@end
