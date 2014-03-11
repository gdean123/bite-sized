#import "Experience.h"

@implementation Experience

- (id)initWithTagline:(NSString *)tagline {
    self = [super init];

    if (self) {
        self.tagline = tagline;
    }

    return self;
}

@end
