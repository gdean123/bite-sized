#import "AppDelegate.h"
#import "BrowseViewController.h"

@interface AppDelegate ()

@property(strong, nonatomic) BrowseViewController *browseViewController;

@end

@implementation AppDelegate

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

    return YES;
}

@end
