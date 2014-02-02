@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>

@class WXCondition;

@interface WXManager : NSObject <CLLocationManagerDelegate>

+(instancetype)sharedManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

- (void)findCurrentLocation;

@end
