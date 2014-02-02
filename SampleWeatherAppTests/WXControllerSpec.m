#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <JRSwizzle/JRSwizzle.h>

#import "UIViewController+ForTesting.h"
#import "WXController.h"
#import "WXController_Private.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WXControllerTableHeaderView.h"

SpecBegin(WXController)

describe(@"wxcontroller", ^{
  __block WXController *_controller;
  beforeEach(^{
    _controller = [[WXController alloc] init];
    viewDidLoadOverrideWasCalled = NO;
    viewWillLayoutSubviewsWasCalled = NO;
  });
  it(@"conforms to UITableViewDataSource", ^{
    expect([_controller conformsToProtocol:@protocol(UITableViewDataSource)]).equal(YES);
  });
  it(@"conforms to UITableViewDelegate", ^{
    expect([_controller conformsToProtocol:@protocol(UITableViewDelegate)]).equal(YES);
  });
  it(@"conforms to UIScrollViewDelegate", ^{
    expect([_controller conformsToProtocol:@protocol(UIScrollViewDelegate)]).equal(YES);
  });
  it(@"view did load should call super", ^{
    NSError *error = nil;
    [UIViewController
     jr_swizzleMethod:@selector(viewDidLoad)
     withMethod:@selector(viewDidLoadOverride)
     error:&error];
    
    [_controller viewDidLoad];
    expect(viewDidLoadOverrideWasCalled).equal(YES);
    
    [UIViewController
     jr_swizzleMethod:@selector(viewDidLoad)
     withMethod:@selector(viewDidLoadOverride)
     error:&error];
  });
  it(@"viewwilllayoutsubviews should call super", ^{
    NSError *error = nil;
    [UIViewController
     jr_swizzleMethod:@selector(viewWillLayoutSubviews)
     withMethod:@selector(viewWillLayoutSubviewsOverride)
     error:&error];
    
    [_controller viewWillLayoutSubviews];
    expect(viewWillLayoutSubviewsWasCalled).equal(YES);
    
    [UIViewController
     jr_swizzleMethod:@selector(viewWillLayoutSubviews)
     withMethod:@selector(viewWillLayoutSubviewsOverride)
     error:&error];
  });
  context(@"blurredImageView", ^{
    __block id blurredImageViewMock;
    before(^{
      blurredImageViewMock = [OCMockObject niceMockForClass:[UIImageView class]];
      [_controller setBlurredImageView:blurredImageViewMock];
    });
    it(@"in view did load should be setup to blur", ^{
      [[blurredImageViewMock expect] setImageToBlur:OCMOCK_ANY blurRadius:10.0f completionBlock:nil];
      [_controller viewDidLoad];
    });
    after(^{
      [blurredImageViewMock verify];
    });
  });
  context(@"viewdidload", ^{
    beforeEach(^{
      [_controller viewDidLoad];
    });
    it(@"view background color should be set to red color", ^{
      expect([[_controller view] backgroundColor]).equal([UIColor redColor]);
    });
    it(@"screenHeight has been set to screen bounds", ^{
      expect([_controller screenHeight]).equal([UIScreen mainScreen].bounds.size.height);
    });
    it(@"backgroundImageView image is not nil", ^{
      expect([_controller backgroundImageView]).notTo.equal(nil);
    });
    it(@"backgroundImageView image set to bg", ^{
      expect([[_controller backgroundImageView] image].CGImage).equal([UIImage imageNamed:@"bg"].CGImage);
    });
    it(@"backgroundImageView content mode set to UIViewContentModeScaleAspectFill", ^{
      expect([[_controller backgroundImageView] contentMode]).equal(UIViewContentModeScaleAspectFill);
    });
    it(@"backgroundImageView added into controller view subviews", ^{
      expect([[_controller backgroundImageView] superview]).equal([_controller view]);
    });
    it(@"blurredImageView is not nil", ^{
      expect([_controller blurredImageView]).notTo.equal(nil);
    });
    it(@"blurredImageView content mode set to UIViewContentModeScaleAspectFill", ^{
      expect([[_controller blurredImageView] contentMode]).equal(UIViewContentModeScaleAspectFill);
    });
    it(@"blurredImageView added into controller view subviews", ^{
      expect([[_controller blurredImageView] superview]).equal([_controller view]);
    });
    it(@"blurredImageView set to alpha in the beginning", ^{
      expect(_controller.blurredImageView.alpha).equal(0);
    });
    it(@"tableView is not nil", ^{
      expect([_controller tableView]).notTo.equal(nil);
    });
    it(@"tableView added into controller view subviews", ^{
      expect([[_controller tableView] superview]).equal([_controller view]);
    });
    it(@"tableView datasource is set", ^{
      expect([[_controller tableView] dataSource]).equal(_controller);
    });
    it(@"tableView delegate is set", ^{
      expect(([[_controller tableView] delegate])).equal(_controller);
    });
    it(@"tableView background color is set", ^{
      expect(([[_controller tableView] backgroundColor])).equal([UIColor clearColor]);
    });
    it(@"tableView separator color is set", ^{
      expect([[_controller tableView] separatorColor]).equal([UIColor colorWithWhite:1.0f alpha:0.2f]);
    });
    it(@"tableView paging is enabled", ^{
      expect(_controller.tableView.pagingEnabled).equal(YES);
    });
    it(@"tableHeaderView should not be nil", ^{
      expect(_controller.tableView.tableHeaderView).notTo.equal(nil);
    });
    it(@"tableHeaderView backgroundColor should be clearColor", ^{
      expect(_controller.tableView.tableHeaderView.backgroundColor).equal([UIColor clearColor]);
    });
    it(@"tableHeaderView class is WXControllerTableHeaderView", ^{
      expect(_controller.tableView.tableHeaderView.class).equal([WXControllerTableHeaderView class]);
    });
  });
  context(@"viewwilllayoutsubviews", ^{
    it(@"backgroundImageView frame should be set to self.view.bounds", ^{
      [_controller viewWillLayoutSubviews];
      expect(_controller.backgroundImageView.frame).equal(_controller.view.bounds);
    });
    it(@"blurredImageView frame should be set to self.view.bounds", ^{
      [_controller viewWillLayoutSubviews];
      expect(_controller.blurredImageView.frame).equal(_controller.view.bounds);
    });
    it(@"tableView frame should be set to self.view.bounds", ^{
      [_controller viewWillLayoutSubviews];
      expect(_controller.tableView.frame).equal(_controller.view.bounds);
    });
  });
  it(@"default preferred status bar style", ^{
    expect([_controller preferredStatusBarStyle]).equal(UIStatusBarStyleLightContent);
  });
  context(@"numberOfSectionsInTableView", ^{
    beforeEach(^{
      id tableViewMock = [OCMockObject niceMockForClass:[UITableView class]];
      [_controller setTableView:tableViewMock];
    });
    it(@"should only have 0 sections if not controller tableview", ^{
      expect([_controller numberOfSectionsInTableView:nil]).equal(0);
    });
    it(@"should only have 2 sections if controller tableview", ^{
      expect([_controller numberOfSectionsInTableView:[_controller tableView]]).equal(2);
    });
  });
  context(@"cellForRowAtIndexPath", ^{
    it(@"cell returned should not be nil", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil]).notTo.equal(nil);
    });
    it(@"cell should have correct identifier", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil].reuseIdentifier).equal(@"CellIdentifier");
    });
    it(@"cell selection style is none", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil].selectionStyle).equal(UITableViewCellSelectionStyleNone);
    });
    it(@"cell background color should be set", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil].backgroundColor).equal([UIColor colorWithWhite:0.0f alpha:0.2f]);
    });
    it(@"cell textlabel textcolor should be set", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil].textLabel.textColor).equal([UIColor whiteColor]);
    });
    it(@"cell detaillabel textcolor should be set", ^{
      expect([_controller tableView:nil cellForRowAtIndexPath:nil].detailTextLabel.textColor).equal([UIColor whiteColor]);
    });
  });
  afterEach(^{
    _controller = nil;
  });
  
});

SpecEnd