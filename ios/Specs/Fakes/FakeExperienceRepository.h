#import <Foundation/Foundation.h>
#import <KSPromise.h>
#import "ExperienceRepository.h"

@interface FakeExperienceRepository : NSObject<ExperienceRepository>

- (void)completeFetchAllWith:(NSArray *)experiences;
- (KSPromise *)fetchAll;

@end
