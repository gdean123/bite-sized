#import "AppDelegate.h"
#import "BrowseViewController.h"
#import "FakeExperienceRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;
    __block BrowseViewController *browseViewController;

    beforeEach(^{
        FakeExperienceRepository *experienceRepository = [[FakeExperienceRepository alloc] init];
        browseViewController = [[BrowseViewController alloc] initWithRepository:experienceRepository];

        appDelegate = [[AppDelegate alloc] initWithBrowseViewController:browseViewController];
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    });

    it(@"sets the root view controller", ^{
        appDelegate.window.rootViewController should equal(browseViewController);
    });

    it(@"sets the key window", ^{
        [[UIApplication sharedApplication] keyWindow] should equal(appDelegate.window);
    });
});

SPEC_END
