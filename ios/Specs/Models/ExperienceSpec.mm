#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{
    __block Experience *experience;

    beforeEach(^{
        experience = [[Experience alloc] initWithTagline:@"Swim under the Golden Gate Bridge"];
    });

    it(@"has a tagline", ^{
        experience.tagline should equal(@"Swim under the Golden Gate Bridge");
    });
});

SPEC_END
