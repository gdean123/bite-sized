#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{

    it(@"assigns a default id", ^{
        Experience *experience = [[Experience alloc] initWithTagline:@"Swim under the Golden Gate Bridge"];
        experience.identifier should equal(-1);
    });

    it(@"has a tagline", ^{
        Experience *experience = [[Experience alloc] initWithTagline:@"Swim under the Golden Gate Bridge"];
        experience.tagline should equal(@"Swim under the Golden Gate Bridge");
    });

    it(@"has an identifier", ^{
        Experience *experience = [[Experience alloc] initWithIdentifier:10 tagline:@"Visit Coit tower"];
        experience.identifier should equal(10);
    });
});

SPEC_END
