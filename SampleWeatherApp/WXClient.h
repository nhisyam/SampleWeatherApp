@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WXClient : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;
- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate;
- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate;
@end
