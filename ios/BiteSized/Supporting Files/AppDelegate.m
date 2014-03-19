#import "AppDelegate.h"
#import "BrowseViewController.h"
#import "RealExperienceRepository.h"
#import "RealImageRepository.h"

@interface AppDelegate ()

@property(strong, nonatomic) BrowseViewController *browseViewController;

@end

@implementation AppDelegate

- (id)init {
    RealExperienceRepository *experienceRepository = [[RealExperienceRepository alloc] init];
    RealImageRepository *imageRepository = [[RealImageRepository alloc] init];
    BrowseViewController *browseViewController = [[BrowseViewController alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository];

    return [self initWithBrowseViewController:browseViewController];
}

- (id)initWithBrowseViewController:(BrowseViewController *)browseViewController {
    self = [super init];
    if (self) {
        self.browseViewController = browseViewController;
    }

    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.browseViewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
