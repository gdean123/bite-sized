#import "Experience.h"

@implementation Experience

const unsigned int NEW_EXPERIENCE_IDENTIFIER = -1;

- (id)initWithTagline:(NSString *)tagline imageUrl:(NSString *)imageUrl {
    return [self initWithIdentifier:NEW_EXPERIENCE_IDENTIFIER tagline:tagline imageUrl:imageUrl];
}

- (id)initWithIdentifier:(unsigned int)identifier tagline:(NSString *)tagline imageUrl:(NSString *)imageUrl {
    self = [super init];

    if (self) {
        self.tagline = tagline;
        self.identifier = identifier;
        self.imageUrl = imageUrl;
    }

    return self;
}

@end
