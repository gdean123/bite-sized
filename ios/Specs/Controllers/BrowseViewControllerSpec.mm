#import "BrowseViewController.h"
#import "FakeExperienceRepository.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BrowseViewControllerSpec)

describe(@"BrowseViewController", ^{
    __block BrowseViewController *browseViewController;
    __block FakeExperienceRepository *experienceRepository;

    beforeEach(^{
        Experience *experience = [[Experience alloc] initWithTagline:@"Run the Lyon Street steps"];
        experienceRepository = [[FakeExperienceRepository alloc] init];

        browseViewController = [[BrowseViewController alloc] initWithRepository:experienceRepository];
        [browseViewController.view setNeedsDisplay];

        [experienceRepository completeFetchAllWith:@[experience]];
    });

    it(@"shows the tagline for the first experience", ^{
        browseViewController.tagline.text should equal(@"Run the Lyon Street steps");
    });
});

SPEC_END
