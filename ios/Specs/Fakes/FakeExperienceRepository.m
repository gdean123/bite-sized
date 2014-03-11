#import <KSDeferred.h>

#import "FakeExperienceRepository.h"

@interface FakeExperienceRepository ()

@property(strong, nonatomic) KSDeferred *deferredExperiences;

@end

@implementation FakeExperienceRepository

- (void)completeFetchAllWith:(NSArray *)experiences {
    [self.deferredExperiences resolveWithValue:experiences];
}

- (KSPromise *)fetchAll {
    self.deferredExperiences = [KSDeferred defer];

    return self.deferredExperiences.promise;
}

@end
