#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <JRSwizzle/JRSwizzle.h>

#import "WXDailyForecast.h"
#import "WXCondition+ForTesting.h"

SpecBegin(WXDailyForecast)

context(@"JSONKeyPathsByPropertyKey", ^{
  it(@"making sure super is called", ^{
    NSError *error = nil;
    [WXCondition
     jr_swizzleClassMethod:@selector(JSONKeyPathsByPropertyKey)
     withClassMethod:@selector(JSONKeyPathsByPropertyKeyOverride)
     error:&error];
    
    [WXDailyForecast JSONKeyPathsByPropertyKey];
    expect(JSONKeyPathsByPropertyKeyWasCalled).equal(YES);
    
    [WXCondition
     jr_swizzleClassMethod:@selector(JSONKeyPathsByPropertyKey)
     withClassMethod:@selector(JSONKeyPathsByPropertyKeyOverride)
     error:&error];
  });
  it(@"tempHigh: temp.max", ^{
    NSDictionary *dict = [WXDailyForecast JSONKeyPathsByPropertyKey];
    expect(dict[@"tempHigh"]).equal(@"temp.max");
  });
  it(@"tempLow: temp.min", ^{
    NSDictionary *dict = [WXDailyForecast JSONKeyPathsByPropertyKey];
    expect(dict[@"tempLow"]).equal(@"temp.min");
  });
});
SpecEnd
