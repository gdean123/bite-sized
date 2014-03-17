#import "RealExperienceRepository.h"
#import "KSDeferred.h"
#import "Experience.h"

@implementation RealExperienceRepository

- (KSPromise *)fetchAll {
    KSDeferred *deferredExperiences = [KSDeferred defer];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://localhost:3000/experiences"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error) {
                    [deferredExperiences rejectWithError:error];
                }
                else {
                    NSArray *experienceArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    Experience *experience = [[Experience alloc] initWithTagline:[[experienceArray firstObject] objectForKey:@"tagline"]];
                    [deferredExperiences resolveWithValue:@[experience]];
                }
            }] resume];

    return deferredExperiences.promise;
}

- (KSPromise *)create:(Experience *)experience {
    KSDeferred *deferredCreation = [KSDeferred defer];

    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/experiences"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *experienceData = [NSString stringWithFormat:@"tagline=%@", experience.tagline];

    request.HTTPBody = [experienceData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    NSDictionary *experienceHash = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    unsigned int experienceId = [[experienceHash objectForKey:@"id"] integerValue];
                    NSString *experienceTagline = [experienceHash objectForKey:@"tagline"];

                    Experience *createdExperience = [[Experience alloc] initWithIdentifier:experienceId tagline:experienceTagline];
                    [deferredCreation resolveWithValue:createdExperience];
                }] resume];

    return deferredCreation.promise;
}

- (KSPromise *)destroy:(Experience *)experience {
    KSDeferred *deferredDestruction = [KSDeferred defer];

    NSString *url = [NSString stringWithFormat:@"http://localhost:3000/experiences/%d", experience.identifier];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"DELETE";

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (error) {
                        [deferredDestruction rejectWithError:error];
                    }
                    else {
                        [deferredDestruction resolveWithValue:nil];
                    }
                }] resume];

    return deferredDestruction.promise;
}

@end