#import "Experience.h"

@implementation Experience

const unsigned int NEW_EXPERIENCE_IDENTIFIER = -1;

- (id)initWithTagline:(NSString *)tagline {
    return [self initWithIdentifier:NEW_EXPERIENCE_IDENTIFIER tagline:tagline];
}

- (id)initWithIdentifier:(unsigned int)identifier tagline:(NSString *)tagline {
    self = [super init];

    if (self) {
        self.tagline = tagline;
        self.identifier = identifier;
    }

    return self;
}

@end
