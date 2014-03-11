#import <KSDeferred.h>

#import "BrowseViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

@interface BrowseViewController ()

@property(strong, nonatomic) id<ExperienceRepository> experienceRepository;

@end

@implementation BrowseViewController

- (id)initWithRepository:(id<ExperienceRepository>)repository {
    self = [super initWithNibName:@"BrowseViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self.experienceRepository fetchAll] then:^NSArray *(NSArray *experiences) {
        Experience *firstExperience = experiences[0];
        self.tagline.text = firstExperience.tagline;

        return experiences;
    } error:^NSError *(NSError *error) {
        NSLog(@"%@", error.description);
        return error;
    }];
}

@end
