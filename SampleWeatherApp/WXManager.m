#import "WXManager.h"
#import "WXManager_Private.h"
#import "WXCondition.h"
#import <TSMessages/TSMessage.h>
#import "WXClient.h"

@implementation WXManager

#pragma mark - Public

+ (id)sharedManager
{
  static dispatch_once_t token;
	static WXManager *object = nil;
	
	dispatch_once(&token,^{
    object = [[WXManager alloc] init];
  });
	return object;
}

- (id)init {
  self = [super init];
  if (self) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _client = [[WXClient alloc] init];
    
    [[[[RACObserve(self, currentLocation)
    ignore:nil]
    flattenMap:^(CLLocation *newLocation) {
      return [RACSignal
              merge:@[[self updateCurrentConditions]
                      ,[self updateDailyForcast]
                      ,[self updateHourlyForcast]
                      ]
              ];
    }] deliverOn:RACScheduler.mainThreadScheduler]
    subscribeError:^(NSError *error) {
      [TSMessage showNotificationWithTitle:@"Error"
                                  subtitle:@"There was a problem fetching the latest weather"
                                      type:TSMessageNotificationTypeError];
    }];
  }
  return self;
}

- (void)findCurrentLocation {
  self.isFirstUpdate = YES;
  [self.locationManager startUpdatingLocation];
}

#pragma mark  - Private

- (RACSignal *)updateCurrentConditions {
  return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate]
          doNext:^(WXCondition *condition) {
            self.currentCondition = condition;
          }];
}

- (RACSignal *)updateDailyForcast {
  return [[self.client fetchDailyForecastForLocation:self.currentLocation.coordinate]
          doNext:^(NSArray *conditions) {
            self.dailyForecast = conditions;
          }];
}

- (RACSignal *)updateHourlyForcast {
  return [[self.client fetchHourlyForecastForLocation:self.currentLocation.coordinate]
          doNext:^(NSArray *conditions) {
            self.hourlyForecast = conditions;
          }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  if (self.isFirstUpdate) {
    self.isFirstUpdate = NO;
    return;
  }
  
  CLLocation *location = [locations lastObject];
  
  if (location.horizontalAccuracy > 0) {
    self.currentLocation = location;
    [self.locationManager stopUpdatingLocation];
  }
}
@end
