#import "RealExperienceRepository.h"
#import "KSDeferred.h"
#import "Experience.h"

@implementation RealExperienceRepository

- (KSPromise *)fetchAll {
    KSDeferred *deferredExperiences = [KSDeferred defer];

    Experience *experience = [[Experience alloc] initWithTagline:@"Go do some fun thing"];
    [deferredExperiences resolveWithValue:@[experience]];

    return deferredExperiences.promise;
}

@end
