#import <UIKit/UIKit.h>

@protocol ExperienceRepository, ImageRepository;

@interface BrowseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tagline;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithExperienceRepository:(id<ExperienceRepository>)experienceRepository imageRepository:(id<ImageRepository>)imageRepository;

@end
