#import "BrowseViewController.h"
#import "FakeExperienceRepository.h"
#import "FakeImageRepository.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BrowseViewControllerSpec)

describe(@"BrowseViewController", ^{
    __block BrowseViewController *browseViewController;
    __block FakeExperienceRepository *experienceRepository;
    __block FakeImageRepository *imageRepository;
    __block UIImage *experienceImage;

    beforeEach(^{
        experienceRepository = [[FakeExperienceRepository alloc] init];
        imageRepository = [[FakeImageRepository alloc] init];

        browseViewController = [[BrowseViewController alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository];
        [browseViewController.view setNeedsDisplay];

        Experience *experience = [[Experience alloc] initWithTagline:@"Pet kittens" imageUrl:@"http://images.com"];
        [experienceRepository completeFetchAllWith:@[experience]];

        experienceImage = [UIImage imageNamed:@"three_funny_cats.png"];
        [imageRepository completeFetchWith:experienceImage];
    });

    it(@"shows the tagline for the first experience", ^{
        browseViewController.tagline.text should equal(@"Pet kittens");
    });

    it(@"shows the image for the first experience", ^{
        NSData *renderedImageData = UIImagePNGRepresentation(browseViewController.imageView.image);
        NSData *expectedImageData = UIImagePNGRepresentation(experienceImage);

        [renderedImageData isEqual:expectedImageData] should be_truthy;
    });
});

SPEC_END
