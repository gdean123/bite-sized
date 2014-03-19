#import <Foundation/Foundation.h>

@interface Experience : NSObject

extern const unsigned int NEW_EXPERIENCE_IDENTIFIER;

@property(assign, nonatomic) unsigned int identifier;
@property(strong, nonatomic) NSString *tagline;
@property(strong, nonatomic) NSString *imageUrl;

- (id)initWithTagline:(NSString *)tagline imageUrl:(NSString *)imageUrl;
- (id)initWithIdentifier:(unsigned int)identifier tagline:(NSString *)tagline imageUrl:(NSString *)imageUrl;

@end
