#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "WXControllerTableHeaderView.h"

SpecBegin(WXControllerTableHeaderView)

context(@"layoutSubviews", ^{
  __block WXControllerTableHeaderView *_view;
  beforeEach(^{
    _view = [[WXControllerTableHeaderView alloc] initWithFrame:CGRectZero];
    [_view layoutSubviews];
  });
  context(@"temperatureLabel", ^{
    it(@"temperatureLabel is not nil", ^{
      expect([_view temperatureLabel]).notTo.equal(nil);
    });
    it(@"temperatureLabel text color is white", ^{
      expect(_view.temperatureLabel.textColor).equal([UIColor whiteColor]);
    });
    it(@"temperatureLabel backgroundColor is clear", ^{
      expect(_view.temperatureLabel.backgroundColor).equal([UIColor clearColor]);
    });
    it(@"temperatureLabel font is set", ^{
      expect(_view.temperatureLabel.font).equal([UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120]);
    });
    it(@"temperatureLabel added as subview", ^{
      expect(_view.temperatureLabel.superview).equal(_view);
    });
  });
  context(@"hiloLabel", ^{
    it(@"hilo label not nil", ^{
      expect(_view.hiloLabel).notTo.equal(nil);
    });
    it(@"hilolabel added to self.view", ^{
      expect(_view.hiloLabel.superview).equal(_view);
    });
    it(@"background color set to clear color", ^{
      expect(_view.hiloLabel.backgroundColor).equal([UIColor clearColor]);
    });
    it(@"textColor set to white color", ^{
      expect(_view.hiloLabel.textColor).equal([UIColor whiteColor]);
    });
    it(@"font is set", ^{
      expect(_view.hiloLabel.font).equal([UIFont fontWithName:@"HelveticaNeue-Light" size:28]);
    });
  });
  context(@"cityLabel", ^{
    it(@"not nil", ^{
      expect(_view.cityLabel).notTo.equal(nil);
    });
    it(@"added to subview", ^{
      expect((_view.cityLabel.superview)).equal(_view);
    });
    it(@"backgroundcolor = clear color", ^{
      expect(_view.cityLabel.backgroundColor).equal([UIColor clearColor]);
    });
    it(@"font has been set", ^{
      expect(_view.cityLabel.font).equal([UIFont fontWithName:@"HelveticaNeue-Light" size:18]);
    });
    it(@"text alignment set to center", ^{
      expect(_view.cityLabel.textAlignment).equal(NSTextAlignmentCenter);
    });
    it(@"text color is white", ^{
      expect(_view.cityLabel.textColor).equal([UIColor whiteColor]);
    });
  });
  context(@"conditionsLabel", ^{
    it(@"added to view subviews", ^{
      expect(_view.conditionsLabel.superview).equal(_view);
    });
    it(@"not nil", ^{
      expect(_view.conditionsLabel).notTo.equal(nil);
    });
    it(@"background color = clear color", ^{
      expect(_view.conditionsLabel.backgroundColor).equal([UIColor clearColor]);
    });
    it(@"textColor is white", ^{
      expect(_view.conditionsLabel.textColor).equal([UIColor whiteColor]);
    });
    it(@"font is set", ^{
      expect(_view.conditionsLabel.font).equal([UIFont fontWithName:@"HelveticaNeue-Light" size:18]);
    });
  });
  context(@"iconView", ^{
    it(@"iconView is not nil", ^{
      expect(_view.iconView).notTo.equal(nil);
    });
    it(@"added to subview", ^{
      expect(_view.iconView.superview).equal(_view);
    });
    it(@"contentMode is AspectFit", ^{
      expect(_view.iconView.contentMode).equal(UIViewContentModeScaleAspectFit);
    });
    it(@"backgroundColor is clear color", ^{
      expect(_view.iconView.backgroundColor).equal([UIColor clearColor]);
    });
  });
  afterEach(^{
    _view = nil;
  });
});

context(@"subview exited", ^{
  __block WXControllerTableHeaderView *_view;
  beforeEach(^{
    _view = [[WXControllerTableHeaderView alloc] initWithFrame:CGRectZero];
  });
  it(@"temperatureLabel exist", ^{
    expect([_view respondsToSelector:@selector(setTemperatureLabel:)]).equal(YES);
    expect([_view respondsToSelector:@selector(temperatureLabel)]).equal(YES);
  });
  it(@"hiloLabel exist", ^{
    expect([_view respondsToSelector:@selector(setHiloLabel:)]).equal(YES);
    expect([_view respondsToSelector:@selector(hiloLabel)]).equal(YES);
  });
  it(@"cityLabel exist", ^{
    expect([_view respondsToSelector:@selector(setCityLabel:)]).equal(YES);
    expect([_view respondsToSelector:@selector(cityLabel)]).equal(YES);
  });
  it(@"conditionsLabel exist", ^{
    expect([_view respondsToSelector:@selector(setConditionsLabel:)]).equal(YES);
    expect([_view respondsToSelector:@selector(conditionsLabel)]).equal(YES);
  });
  it(@"iconView exist", ^{
    expect([_view respondsToSelector:@selector(setIconView:)]).equal(YES);
    expect([_view respondsToSelector:@selector(iconView)]).equal(YES);
  });
  afterEach(^{
    _view = nil;
  });
});

SpecEnd
