#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{

    it(@"assigns a default id", ^{
        Experience *experience = [[Experience alloc] initWithTagline:@"Swim under the Golden Gate Bridge" imageUrl:@"whatever"];
        experience.identifier should equal(-1);
    });

    it(@"has identifier, tagline, and imageUrl properties", ^{
        Experience *experience = [[Experience alloc] initWithIdentifier:10 tagline:@"Swim under the Golden Gate Bridge" imageUrl:@"http://images.com/something.png"];

        experience.identifier should equal(10);
        experience.tagline should equal(@"Swim under the Golden Gate Bridge");
        experience.imageUrl should equal(@"http://images.com/something.png");
    });
});

SPEC_END
