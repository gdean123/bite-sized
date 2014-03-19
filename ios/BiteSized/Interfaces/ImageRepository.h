#import <Foundation/Foundation.h>

@class KSPromise;

@protocol ImageRepository <NSObject>

- (KSPromise *)fetch:(NSString *)imageUrl;

@end
