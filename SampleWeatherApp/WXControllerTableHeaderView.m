#import "WXControllerTableHeaderView.h"

@implementation WXControllerTableHeaderView

- (void)layoutSubviews {
  CGRect headerFrame = self.frame;
  CGFloat inset = 20.0f;
  CGFloat temperatureHeight = 110.0f;
  CGFloat hiloHeight = 40.0f;
  CGFloat iconHeight = 30.0f;
  
  CGRect hiloFrame = CGRectMake(inset, headerFrame.size.height - hiloHeight, headerFrame.size.width - (2.0f * inset), hiloHeight);
  
  CGRect temperatureFrame = CGRectMake(inset, headerFrame.size.height - (temperatureHeight + hiloHeight), headerFrame.size.width - (2.0f * inset), temperatureHeight);
  
  CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
  
  CGRect conditionsFrame = iconFrame;
  conditionsFrame.size.width = headerFrame.size.width - (((2.0f * inset) + iconHeight) + 10.0f);
  conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10.0f);
  
  if (!_temperatureLabel) {
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
    temperatureLabel.backgroundColor = [UIColor clearColor];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.text = @"0°";
    temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [self addSubview:temperatureLabel];
    self.temperatureLabel = temperatureLabel;
  }
  
  if (!_hiloLabel) {
    UILabel *hiloLabel = [[UILabel alloc] initWithFrame:hiloFrame];
    hiloLabel.backgroundColor = [UIColor clearColor];
    hiloLabel.textColor = [UIColor whiteColor];
    hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    hiloLabel.text = @"0° / 0°";
    [self addSubview:hiloLabel];
    self.hiloLabel = hiloLabel;
  }
  
  if (!_cityLabel) {
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.bounds.size.width, 30.0f)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    cityLabel.text = @"Loading...";
    [self addSubview:cityLabel];
    self.cityLabel = cityLabel;
  }
  
  if (!_conditionsLabel) {
    UILabel *conditionsLabel = [[UILabel alloc] initWithFrame:conditionsFrame];
    conditionsLabel.backgroundColor = [UIColor clearColor];
    conditionsLabel.textColor = [UIColor whiteColor];
    conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    [self addSubview:conditionsLabel];
    self.conditionsLabel = conditionsLabel;
  }
  
  if(!_iconView) {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconView.backgroundColor = [UIColor clearColor];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:iconView];
    self.iconView = iconView;
  }
}
@end
