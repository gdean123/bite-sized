#import "KSPromise.h"

#import "RealExperienceRepository.h"
#import "Experience.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RealExperienceRepositorySpec)

describe(@"RealExperienceRepository", ^{
    __block RealExperienceRepository *realExperienceRepository;
    __block Blocker *blocker;

    beforeEach(^{
        realExperienceRepository = [[RealExperienceRepository alloc] init];
        blocker = [[Blocker alloc] init];
    });

    id (^logErrors)(NSError *) = ^id(NSError *error) {
        NSLog(@"Error: %@", error.description);
        return error;
    };

    void (^createExperienceWithTagline)(NSString *) = ^(NSString *tagline) {
        Experience *experienceToCreate = [[Experience alloc] initWithTagline:tagline];

        [[realExperienceRepository create:experienceToCreate] then:^id(Experience *createdExperience) {
            [blocker doneWaiting];
            return createdExperience;
        } error:logErrors];

        [blocker wait];
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

    it(@"can retrieve saved experiences", ^{
        createExperienceWithTagline(@"Swim to Alcatraz");
        NSArray *retrievedExperiences = fetchAllExperiences();

        Experience *firstExperience = [retrievedExperiences firstObject];
        firstExperience.tagline should equal(@"Swim to Alcatraz");
    });

    xit(@"rejects the promise if the request fails", ^{});
});

SPEC_END
