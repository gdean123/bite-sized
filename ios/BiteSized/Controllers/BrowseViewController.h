#import <UIKit/UIKit.h>

@protocol ExperienceRepository;

@interface BrowseViewController : UIViewController

- (id)initWithRepository:(id<ExperienceRepository>)repository;

@property (weak, nonatomic) IBOutlet UILabel *tagline;

@end
