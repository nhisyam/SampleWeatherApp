#import "WXCondition.h"

@interface WXCondition ()
+ (NSDictionary *)imageMap;
+ (NSValueTransformer *)dateJSONTransformer;
+ (NSValueTransformer *)sunriseJSONTransformer;
+ (NSValueTransformer *)sunsetJSONTransformer;
+ (NSValueTransformer *)conditionJSONTransformer;
+ (NSValueTransformer *)iconJSONTransformer;
+ (NSValueTransformer *)windSpeedJSONTransformer;
@end

@implementation WXCondition

+ (NSDictionary *)imageMap {
  static NSDictionary *_imageMap = nil;
  if (!_imageMap) {
    _imageMap =
    @{
      @"01d" : @"weather-clear",
      @"02d" : @"weather-few",
      @"03d" : @"weather-few",
      @"04d" : @"weather-broken",
      @"09d" : @"weather-shower",
      @"10d" : @"weather-rain",
      @"11d" : @"weather-tstorm",
      @"13d" : @"weather-snow",
      @"50d" : @"weather-mist",
      @"01n" : @"weather-moon",
      @"02n" : @"weather-few-night",
      @"03n" : @"weather-few-night",
      @"04n" : @"weather-broken",
      @"09n" : @"weather-shower",
      @"10n" : @"weather-rain-night",
      @"11n" : @"weather-tstorm",
      @"13n" : @"weather-snow",
      @"50n" : @"weather-mist",
      };
  }
  return _imageMap;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return
  @{@"date": @"dt"
    ,@"locationName": @"name"
    ,@"humidity": @"main.humidity"
    ,@"temperature": @"main.temp"
    ,@"tempHigh": @"main.temp_max"
    ,@"tempLow": @"main.temp_min"
    ,@"sunrise": @"sys.sunrise"
    ,@"sunset": @"sys.sunset"
    ,@"conditionDescription": @"weather.description"
    ,@"condition": @"weather.main"
    ,@"icon": @"weather.icon"
    ,@"windBearing": @"wind.deg"
    ,@"windSpeed": @"wind.speed"
    };
}

+ (NSValueTransformer *)dateJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
    return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
  } reverseBlock:^id(NSDate *date) {
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
  }];
}

+ (NSValueTransformer *)sunriseJSONTransformer {
  return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
  return [self dateJSONTransformer];
}

+ (NSValueTransformer *)conditionJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *values) {
    return [values firstObject];
  } reverseBlock:^id(NSString *str) {
    return @[str];
  }];
}

+ (NSValueTransformer *)iconJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *values) {
    return [values firstObject];
  } reverseBlock:^id(NSString *str) {
    return @[str];
  }];
}

+ (NSValueTransformer *)conditionDescriptionJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *values) {
    return [values firstObject];
  } reverseBlock:^id(NSString *str) {
    return @[str];
  }];
}

#define MPS_TO_MPH 2.23694f

+ (NSValueTransformer *)windSpeedJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *num) {
    return @(num.floatValue*MPS_TO_MPH);
  } reverseBlock:^id(NSNumber *speed) {
    return @(speed.floatValue/MPS_TO_MPH);
  }];
}

- (NSString *)imageName {
  return [WXCondition imageMap][self.icon];
}
@end
