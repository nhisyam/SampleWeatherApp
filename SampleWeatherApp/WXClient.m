#import "WXClient.h"
#import <Mantle/Mantle.h>
#import "WXCondition.h"
#import "WXDailyForecast.h"

@implementation WXClient

- (id)init {
  self = [super init];
  if (self) {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
  }
  return self;
}

#pragma mark - Public

//TODO: fetchJSONFromURL UT
- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
  return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (!error) {
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (!jsonError) {
          [subscriber sendNext:json];
        } else {
          [subscriber sendError:jsonError];
        }
      } else {
        [subscriber sendError:error];
      }
      [subscriber sendCompleted];
    }];
    [dataTask resume];
    return [RACDisposable disposableWithBlock:^{
      [dataTask cancel];
    }];
  }] doError:^(NSError *error) {
  }];
}

//TODO: fetchCurrentConditionsForLocation UT
- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate {
  NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial", coordinate.latitude, coordinate.longitude];
  NSURL *url = [NSURL URLWithString:urlString];
  return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
    return [MTLJSONAdapter modelOfClass:[WXCondition class] fromJSONDictionary:json error:nil];
  }];
}

//TODO: fetchHourlyForecastForLocation UT
- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate {
  NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&units=imperial&cnt=12", coordinate.latitude, coordinate.longitude];
  NSURL *url = [NSURL URLWithString:urlString];
  return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
    RACSequence *list = [json[@"list"] rac_sequence];
    return [[list map:^(NSDictionary *item) {
      return [MTLJSONAdapter modelOfClass:[WXCondition class] fromJSONDictionary:item error:nil];
    }] array];
  }];
}

//TODO: fetchDailyForecastForLocation UT
- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate {
  NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&units=imperial&cnt=7", coordinate.latitude, coordinate.longitude];
  NSURL *url = [NSURL URLWithString:urlString];
  return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
    RACSequence *list = [json[@"list"] rac_sequence];
    return [[list map:^(NSDictionary *item) {
      return [MTLJSONAdapter modelOfClass:[WXDailyForecast class] fromJSONDictionary:item error:nil];
    }] array];
  }];
}
@end
