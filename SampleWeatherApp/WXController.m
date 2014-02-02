#import "WXController.h"
#import "WXController_Private.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WXControllerTableHeaderView.h"
#import "WXManager.h"
#import "WXCondition.h"

@implementation WXController

- (id)init {
  self = [super init];
  if (self){
    _dailyFormatter = [[NSDateFormatter alloc] init];
    _dailyFormatter.dateFormat = @"EEEE";
    _hourlyFormatter = [[NSDateFormatter alloc] init];
    _hourlyFormatter.dateFormat = @"h a";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor redColor];
  
  self.screenHeight = [UIScreen mainScreen].bounds.size.height;
  
  UIImage *bg = [UIImage imageNamed:@"bg"];
  
  if (!_backgroundImageView) {
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:bg];
    [self.view addSubview:bgImgView];
    self.backgroundImageView = bgImgView;
  }
  
  _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
  
  if (!_blurredImageView) {
    UIImageView *blurredImgView = [[UIImageView alloc] init];
    [self.view addSubview:blurredImgView];
    self.blurredImageView = blurredImgView;
  }
  
  _blurredImageView.alpha = 0.0f;
  _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
  [_blurredImageView setImageToBlur:bg blurRadius:10.0f completionBlock:nil];

  if (!_tableView) {
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
  }
  
  _tableView.dataSource = self;
  _tableView.delegate = self;
  _tableView.backgroundColor = [UIColor clearColor];
  _tableView.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
  _tableView.pagingEnabled = YES;

  CGRect headerFrame = [UIScreen mainScreen].bounds;
  WXControllerTableHeaderView *header = [[WXControllerTableHeaderView alloc] initWithFrame:headerFrame];
  header.backgroundColor = [UIColor clearColor];
  self.tableView.tableHeaderView = header;
  
  [[RACObserve([WXManager sharedManager], currentCondition)
    deliverOn:RACScheduler.mainThreadScheduler]
   subscribeNext:^(WXCondition *newCondition) {
     header.temperatureLabel.text = [NSString stringWithFormat:@"%.0f°", newCondition.temperature.floatValue];
     header.conditionsLabel.text = [newCondition.condition capitalizedString];
     header.cityLabel.text = [newCondition.locationName capitalizedString];
     header.iconView.image = [UIImage imageNamed:[newCondition imageName]];
   }];
  
  RAC(header, hiloLabel.text) =
  [[RACSignal combineLatest:
    @[[RACObserve([WXManager sharedManager], currentCondition.tempHigh) ignore:nil]
      , [RACObserve([WXManager sharedManager], currentCondition.tempLow) ignore:nil]
      ] reduce:^id (NSNumber *hi, NSNumber *low){
        return [NSString stringWithFormat:@"%.0f° / %.0f°", hi.floatValue, low.floatValue];
      }]
    deliverOn:RACScheduler.mainThreadScheduler];
  
  [[RACObserve([WXManager sharedManager], hourlyForecast)
    deliverOn:RACScheduler.mainThreadScheduler]
   subscribeNext:^(NSArray *conditions) {
     [self.tableView reloadData];
   }];
  
  [[RACObserve([WXManager sharedManager], dailyForecast)
    deliverOn:RACScheduler.mainThreadScheduler]
   subscribeNext:^(NSArray *conditions) {
     [self.tableView reloadData];
   }];
  
  [[WXManager sharedManager] findCurrentLocation];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  CGRect bounds = self.view.bounds;
  _backgroundImageView.frame = bounds;
  _blurredImageView.frame = bounds;
  _tableView.frame = bounds;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

#pragma mark - Private

- (void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title {
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
  cell.textLabel.text = title;
  cell.detailTextLabel.text = @"";
  cell.imageView.image = nil;
}

- (void)configureHourlyCell:(UITableViewCell *)cell weather:(WXCondition *)weather {
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
  cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
  cell.textLabel.text = [self.hourlyFormatter stringFromDate:weather.date];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f°", weather.temperature.floatValue];
  cell.imageView.image = [UIImage imageNamed:[weather imageName]];
  cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)configureDailyCell:(UITableViewCell *)cell weather:(WXCondition *)weather {
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
  cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
  cell.textLabel.text = [self.dailyFormatter stringFromDate:weather.date];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f° / %.0f°", weather.tempHigh.floatValue, weather.tempLow.floatValue];
  cell.imageView.image = [UIImage imageNamed:[weather imageName]];
  cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return ([tableView isEqual:_tableView]) ? 2 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return MIN([[WXManager sharedManager].hourlyForecast count], 6) + 1;
  }
  return MIN([[WXManager sharedManager].dailyForecast count], 6) + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
  cell.textLabel.textColor = [UIColor whiteColor];
  cell.detailTextLabel.textColor = [UIColor whiteColor];
  
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      [self configureHeaderCell:cell title:@"Hourly Forecast"];
    } else {
      WXCondition *weather = [WXManager sharedManager].hourlyForecast[indexPath.row - 1];
      [self configureHourlyCell:cell weather:weather];
    }
  } else if (indexPath.section == 1) {
    if (indexPath.row == 0) {
      [self configureHeaderCell:cell title:@"Daily Forecast"];
    } else {
      WXCondition *weather = [WXManager sharedManager].dailyForecast[indexPath.row - 1];
      [self configureDailyCell:cell weather:weather];
    }
  }
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
  return self.screenHeight / (CGFloat)cellCount;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat height = scrollView.bounds.size.height;
  CGFloat position = MAX(scrollView.contentOffset.y, 0.0f);
  CGFloat percent = MIN(position / height, 1.0);
  self.blurredImageView.alpha = percent;
}
@end
