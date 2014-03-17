#import <Foundation/Foundation.h>

@interface Experience : NSObject

extern const unsigned int NEW_EXPERIENCE_IDENTIFIER;

- (id)initWithTagline:(NSString *)tagline;
- (id)initWithIdentifier:(unsigned int)identifier tagline:(NSString *)tagline;

@property(strong, nonatomic) NSString *tagline;
@property(assign, nonatomic) unsigned int identifier;

@end
