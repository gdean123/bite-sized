#import <UIKit/UIKit.h>

@class BrowseViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (id)initWithBrowseViewController:(BrowseViewController *)browseViewController;

@end
