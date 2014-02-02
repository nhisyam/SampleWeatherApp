#import "WXCondition.h"

extern BOOL JSONKeyPathsByPropertyKeyWasCalled;

@interface WXCondition (ForTesting) <MTLJSONSerializing>
+ (NSDictionary *)JSONKeyPathsByPropertyKeyOverride;
@end
