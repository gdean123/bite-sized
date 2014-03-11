#import <Foundation/Foundation.h>

@class KSPromise;

@protocol ExperienceRepository

- (KSPromise *)fetchAll;

@end
