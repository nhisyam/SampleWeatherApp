#import "WXCondition+ForTesting.h"

BOOL JSONKeyPathsByPropertyKeyWasCalled ;

@implementation WXCondition (ForTesting)
+ (NSDictionary *)JSONKeyPathsByPropertyKeyOverride {
  JSONKeyPathsByPropertyKeyWasCalled = YES;
  return [WXCondition JSONKeyPathsByPropertyKeyOverride];
}
@end
