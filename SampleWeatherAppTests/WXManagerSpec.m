#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WXManager.h"
#import "WXManager_Private.h"

SpecBegin(WXManager)

context(@"header", ^{
  __block WXManager *_manager;
  beforeEach(^{
    _manager = [[WXManager alloc] init];
  });
  it(@"conform to protocol", ^{
    expect([_manager conformsToProtocol:@protocol(CLLocationManagerDelegate)]).equal(YES);
  });
  it(@"contains property currentLocation READONLY ", ^{
    expect([_manager respondsToSelector:@selector(currentLocation)]).equal(YES);
  });
  it(@"contains property currentCondition READONLY ", ^{
    expect([_manager respondsToSelector:@selector(currentCondition)]).equal(YES);
  });
  it(@"contains property hourlyForecast READONLY ", ^{
    expect([_manager respondsToSelector:@selector(hourlyForecast)]).equal(YES);
  });
  it(@"contains property dailyForecast READONLY ", ^{
    expect([_manager respondsToSelector:@selector(dailyForecast)]).equal(YES);
  });
  it(@"contains method findCurrentLocation", ^{
    expect([_manager respondsToSelector:@selector(findCurrentLocation)]).equal(YES);
  });
  context(@"init", ^{
    it(@"_locationManager is not nil", ^{
      expect([_manager locationManager]).notTo.equal(nil);
    });
    it(@"locationManager delegate is WXManager", ^{
      expect([[_manager locationManager] delegate]).notTo.equal(nil);
      expect((_manager.locationManager.delegate)).equal(_manager);
    });
    it(@"client is not nil", ^{
      expect(_manager.client).notTo.equal(nil);
    });
  });
  afterEach(^{
    _manager = nil;
  });
});

context(@"singleton", ^{
  it(@"singleton should return the same instance", ^{
    id instance1 = [WXManager sharedManager];
    id instance2 = [WXManager sharedManager];
    expect(instance1).equal(instance2);
  });
});
SpecEnd
