#import "KSPromise.h"

#import "RealExperienceRepository.h"
#import "Experience.h"
#import "Blocker.h"
#import "KSDeferred.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RealExperienceRepositorySpec)

describe(@"RealExperienceRepository", ^{
    __block RealExperienceRepository *realExperienceRepository;
    __block Blocker *blocker;
    __block Experience *createdExperience;

    id (^logErrors)(NSError *) = ^id(NSError *error) {
        NSLog(@"Error: %@", error.description);
        return error;
    };

    Experience *(^createExperienceWithTagline)(NSString *) = ^(NSString *tagline) {
        Experience *experienceToCreate = [[Experience alloc] initWithTagline:tagline imageUrl:@"http://images.com/some_image.png"];
        __block Experience *createdExperience;

        [[realExperienceRepository create:experienceToCreate] then:^id(Experience *experience) {
            [blocker doneWaiting];
            createdExperience = experience;
            return experience;
        } error:logErrors];

        [blocker wait];
        return createdExperience;
    };

    NSArray *(^fetchAllExperiences)() = ^NSArray *() {
        __block NSArray *retrievedExperiences;

        [[realExperienceRepository fetchAll] then:^NSArray *(NSArray *experiences) {
            retrievedExperiences = experiences;
            [blocker doneWaiting];
            return experiences;
        } error:logErrors];

        [blocker wait];
        return retrievedExperiences;
    };

    void (^destroyExperience)(Experience *) = ^(Experience *experienceToDestroy) {
        [[realExperienceRepository destroy:experienceToDestroy] then:^id(id unused) {
            [blocker doneWaiting];
            return unused;
        } error:logErrors];

        [blocker wait];
    };

    beforeEach(^{
        realExperienceRepository = [[RealExperienceRepository alloc] init];
        blocker = [[Blocker alloc] init];
        createdExperience = createExperienceWithTagline(@"Pet a rabbit");
    });

    afterEach(^{
        destroyExperience(createdExperience);
    });

    it(@"can retrieve saved experiences", ^{
        Experience *lastExperience = [fetchAllExperiences() lastObject];
        lastExperience.tagline should equal(@"Pet a rabbit");
    });
});

SPEC_END
