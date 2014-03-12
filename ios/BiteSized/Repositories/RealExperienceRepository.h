#import <Foundation/Foundation.h>
#import "ExperienceRepository.h"
#import "Experience.h"

@interface RealExperienceRepository : NSObject<ExperienceRepository>

- (KSPromise *)fetchAll;
- (KSPromise *)create:(Experience *)experience;

@end
