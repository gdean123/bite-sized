#import <Foundation/Foundation.h>
#import "ImageRepository.h"

@interface FakeImageRepository : NSObject <ImageRepository>

- (void)completeFetchWith:(UIImage *)image;

@end
