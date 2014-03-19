#import <KSDeferred.h>

#import "BrowseViewController.h"
#import "ExperienceRepository.h"
#import "ImageRepository.h"
#import "Experience.h"

@interface BrowseViewController ()

@property(strong, nonatomic) id<ExperienceRepository> experienceRepository;
@property(strong, nonatomic) id<ImageRepository> imageRepository;

@end

@implementation BrowseViewController

- (id)initWithExperienceRepository:(id<ExperienceRepository>)experienceRepository imageRepository:(id<ImageRepository>)imageRepository {
    self = [super initWithNibName:@"BrowseViewController" bundle:nil];
    if (self) {
        self.experienceRepository = experienceRepository;
        self.imageRepository = imageRepository;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    KSPromise *promiseToFetchExperiences = [self.experienceRepository fetchAll];
    KSPromise *promiseToUpdateTagline = [self updateTaglineAfter:promiseToFetchExperiences];
    KSPromise *promiseToFetchImage = [self fetchImageAfter:promiseToUpdateTagline];
    [self updateImageViewAfter:promiseToFetchImage];
}

#pragma mark -- Private

- (KSPromise *)updateTaglineAfter:(KSPromise *)promise {
    return [promise then:^Experience *(NSArray *experiences) {
        Experience *firstExperience = experiences[0];
        self.tagline.text = firstExperience.tagline;

        return firstExperience;
    } error:^id(NSError *error) {
        return error;
    }];
}

- (KSPromise *)fetchImageAfter:(KSPromise *)promise {
    return [promise then:^KSPromise *(Experience *experience) {
        return [self.imageRepository fetch:experience.imageUrl];
    } error:^id(NSError *error) {
        return error;
    }];
}

- (KSPromise *)updateImageViewAfter:(KSPromise *)promise {
    return [promise then:^id(UIImage *image) {
        self.imageView.image = image;
        return nil;
    } error:^id(NSError *error) {
        return error;
    }];
}

@end
