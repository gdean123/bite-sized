#import <KSDeferred.h>
#import "FakeImageRepository.h"

@interface FakeImageRepository ()

@property(strong, nonatomic) KSDeferred *deferredImage;

@end

@implementation FakeImageRepository

- (KSPromise *)fetch:(NSString *)imageUrl {
    self.deferredImage = [KSDeferred defer];

    return self.deferredImage.promise;
}

- (void)completeFetchWith:(UIImage *)image {
    [self.deferredImage resolveWithValue:image];
}

@end
