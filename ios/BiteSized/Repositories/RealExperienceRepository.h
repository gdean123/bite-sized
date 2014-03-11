#import <Foundation/Foundation.h>
#import "ExperienceRepository.h"

@interface RealExperienceRepository : NSObject<ExperienceRepository>

- (KSPromise *)fetchAll;

@end
