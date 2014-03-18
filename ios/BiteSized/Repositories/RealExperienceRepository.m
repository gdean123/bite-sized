#import "RealExperienceRepository.h"
#import "KSDeferred.h"

#import "NSURLSession+BiteSized.h"
#import "Experience.h"
#import "HttpClient.h"

@implementation RealExperienceRepository

- (KSPromise *)fetchAll {
    KSDeferred *deferredExperiences = [KSDeferred defer];
    HttpClient *client = [[HttpClient alloc] initWithSession:[NSURLSession sharedSession]];

    [client getList:@"http://localhost:3000/experiences" then:^(NSArray *experienceList) {
        Experience *experience = [[Experience alloc] initWithTagline:[[experienceList firstObject] objectForKey:@"tagline"]];
        [deferredExperiences resolveWithValue:@[experience]];
    } error:^(NSError *error) {}];

    return deferredExperiences.promise;
}

- (KSPromise *)create:(Experience *)experience {
    KSDeferred *deferredCreation = [KSDeferred defer];
    HttpClient *client = [[HttpClient alloc] initWithSession:[NSURLSession sharedSession]];

    [client post:@"http://localhost:3000/experiences"
        withBody:@{@"tagline": experience.tagline}
            then:^(NSDictionary *experienceHash) {
                unsigned int experienceId = [[experienceHash objectForKey:@"id"] integerValue];
                NSString *experienceTagline = [experienceHash objectForKey:@"tagline"];

                Experience *createdExperience = [[Experience alloc] initWithIdentifier:experienceId tagline:experienceTagline];
                [deferredCreation resolveWithValue:createdExperience];
            }
           error:^(NSError *error) {}];

    return deferredCreation.promise;
}

- (KSPromise *)destroy:(Experience *)experience {
    KSDeferred *deferredDestruction = [KSDeferred defer];
    HttpClient *client = [[HttpClient alloc] initWithSession:[NSURLSession sharedSession]];

    NSString *url = [NSString stringWithFormat:@"http://localhost:3000/experiences/%d", experience.identifier];

    [client delete:url then:^{
        [deferredDestruction resolveWithValue:nil];
    } error:^(NSError *error) {
        [deferredDestruction rejectWithError:error];
    }];

    return deferredDestruction.promise;
}

@end