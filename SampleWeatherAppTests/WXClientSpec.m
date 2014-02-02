#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WXClient.h"

SpecBegin(WXClient)

context(@"Public Methods", ^{
  __block WXClient *_client;
  beforeEach(^{
    _client = [[WXClient alloc] init];
  });
  it(@"should have fetchJSONFromURL:", ^{
    expect([_client respondsToSelector:@selector(fetchJSONFromURL:)]).equal(YES);
  });
  it(@"should have fetchCurrentConditionsForLocation:", ^{
    expect([_client respondsToSelector:@selector(fetchCurrentConditionsForLocation:)]).equal(YES);
  });
  it(@"should have fetchHourlyForecastForLocation:", ^{
    expect([_client respondsToSelector:@selector(fetchHourlyForecastForLocation:)]).equal(YES);
  });
  it(@"should have fetchDailyForecastForLocation:", ^{
    expect([_client respondsToSelector:@selector(fetchDailyForecastForLocation:)]).equal(YES);
  });
  it(@"should have a property called session", ^{
    expect([_client respondsToSelector:@selector(session)]).equal(YES);
    expect([_client respondsToSelector:@selector(setSession:)]).equal(YES);
  });
  context(@"init", ^{
    it(@"session should not be nil", ^{
      expect(_client.session).notTo.equal(nil);
    });
  });
  /**
   How to do unit testing for RACSignal?
   */
//  context(@"fetchJSONFromURL", ^{
//    it(@"returned signal is valid", ^{
//      id mockURL = [OCMockObject niceMockForClass:[NSURL class]];
//      id mockSession = [OCMockObject niceMockForClass:[NSURLSession class]];
//      [[mockSession expect] dataTaskWithURL:mockURL completionHandler:nil];
//      RACSignal *signal = [_client fetchJSONFromURL:mockURL];
//      [mockSession verify];
//    });
//  });
  afterEach(^{
    _client = nil;
  });
});
SpecEnd
