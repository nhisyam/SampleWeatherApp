#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WXCondition.h"

#import <Mantle/Mantle.h>

@interface WXCondition ()
+ (NSDictionary *)imageMap;
+ (NSValueTransformer *)dateJSONTransformer;
+ (NSValueTransformer *)sunriseJSONTransformer;
+ (NSValueTransformer *)sunsetJSONTransformer;
+ (NSValueTransformer *)weatherJSONTransformer;
+ (NSValueTransformer *)windSpeedJSONTransformer;
@end

SpecBegin(WXCondition)

context(@"interface", ^{
  it(@"conforms to MTLJSONSerializing", ^{
    expect([WXCondition conformsToProtocol:@protocol(MTLJSONSerializing)]).equal(YES);
  });
});

context(@"imageMap", ^{
  __block WXCondition *_condition = nil;
  beforeEach(^{
    _condition = [[WXCondition alloc] init];
  });
  it(@"imageName should return weather-mist for icon name 50d", ^{
    _condition.icon = @"50d";
    
    expect(([_condition imageName])).equal(@"weather-mist");
  });
  afterEach(^{
    _condition = nil;
  });
});

context(@"imageMap", ^{
  it(@"imageMap should return dictionary", ^{
    expect([WXCondition imageMap]).notTo.equal(nil);
  });
  it(@"01d should return weather-clear", ^{
    expect([WXCondition imageMap][@"01d"]).equal(@"weather-clear");
  });
  it(@"02d should return weather-few", ^{
    expect([WXCondition imageMap][@"02d"]).equal(@"weather-few");
  });
  it(@"03d should return weather-few", ^{
    expect([WXCondition imageMap][@"03d"]).equal(@"weather-few");
  });
  it(@"04d should return weather-broken", ^{
    expect([WXCondition imageMap][@"04d"]).equal(@"weather-broken");
  });
  it(@"09d should return weather-shower", ^{
    expect([WXCondition imageMap][@"09d"]).equal(@"weather-shower");
  });
  it(@"10d should return weather-rain", ^{
    expect([WXCondition imageMap][@"10d"]).equal(@"weather-rain");
  });
  it(@"11d should return weather-tstorm", ^{
    expect([WXCondition imageMap][@"11d"]).equal(@"weather-tstorm");
  });
  it(@"13d should return weather-snow", ^{
    expect([WXCondition imageMap][@"13d"]).equal(@"weather-snow");
  });
  it(@"50d should return weather-mist", ^{
    expect([WXCondition imageMap][@"50d"]).equal(@"weather-mist");
  });
  it(@"01n should return weather-moon", ^{
    expect([WXCondition imageMap][@"01n"]).equal(@"weather-moon");
  });
  it(@"02n should return weather-few-night", ^{
    expect([WXCondition imageMap][@"02n"]).equal(@"weather-few-night");
  });
  it(@"03n should return weather-few-night", ^{
    expect([WXCondition imageMap][@"03n"]).equal(@"weather-few-night");
  });
  it(@"04n should return weather-broken", ^{
    expect([WXCondition imageMap][@"04n"]).equal(@"weather-broken");
  });
  it(@"09n should return weather-shower", ^{
    expect([WXCondition imageMap][@"09n"]).equal(@"weather-shower");
  });
  it(@"10n should return weather-rain-night", ^{
    expect([WXCondition imageMap][@"10n"]).equal(@"weather-rain-night");
  });
  it(@"11n should return weather-tstorm", ^{
    expect([WXCondition imageMap][@"11n"]).equal(@"weather-tstorm");
  });
  it(@"13n should return weather-snow", ^{
    expect([WXCondition imageMap][@"13n"]).equal(@"weather-snow");
  });
  it(@"50n should return weather-mist", ^{
    expect([WXCondition imageMap][@"50n"]).equal(@"weather-mist");
  });
});

context(@"JSONKeyPathsByPropertyKey", ^{
  it(@"date: dt", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"date"]).equal(@"dt");
  });
  it(@"locationName: name", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"locationName"]).equal(@"name");
  });
  it(@"humidity: main.humidity", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"humidity"]).equal(@"main.humidity");
  });
  it(@"temperature: main.temp", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"temperature"]).equal(@"main.temp");
  });
  it(@"tempHigh: main.temp_max", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"tempHigh"]).equal(@"main.temp_max");
  });
  it(@"tempLow: main.temp_min", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"tempLow"]).equal(@"main.temp_min");
  });
  it(@"sunrise: sys.sunrise", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"sunrise"]).equal(@"sys.sunrise");
  });
  it(@"sunset: sys.sunset", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"sunset"]).equal(@"sys.sunset");
  });
  it(@"conditionDescription: weather.description", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"conditionDescription"]).equal(@"weather.description");
  });
  it(@"condition: weather.main", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"condition"]).equal(@"weather.main");
  });
  it(@"icon: weather.icon", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"icon"]).equal(@"weather.icon");
  });
  it(@"windBearing: wind.deg", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"windBearing"]).equal(@"wind.deg");
  });
  it(@"windSpeed: wind.speed", ^{
    expect([WXCondition JSONKeyPathsByPropertyKey][@"windSpeed"]).equal(@"wind.speed");
  });
});

it(@"jsonkeypathsbypropertykey is not nil", ^{
  expect([WXCondition JSONKeyPathsByPropertyKey]).notTo.equal(nil);
});

SpecEnd
