#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "NHMAppDelegate.h"
#import "WXController.h"

SpecBegin(NHMAppDelegate)

describe(@"NHMAppDelegate", ^{
  __block NHMAppDelegate *_appDelegate;
  
  beforeEach(^{
    _appDelegate = [[NHMAppDelegate alloc] init];
  });
  context(@"when application did finish launching", ^{
    beforeEach(^{
      [_appDelegate application:nil didFinishLaunchingWithOptions:nil];
    });
    it(@"should have root view controller", ^{
      expect([_appDelegate rootViewController]).notTo.equal(nil);
    });
    it(@"rootviewcontroller class is WXController", ^{
      expect([[_appDelegate rootViewController] isKindOfClass:[WXController class]]).equal(YES);
    });
    it(@"window root controller should not be nil", ^{
      expect([[_appDelegate window] rootViewController]).notTo.equal(nil);
    });
    it(@"window root controller should be set to app delegate rootviewcontroller", ^{
      expect([[_appDelegate window] rootViewController]).equal([_appDelegate rootViewController]);
    });
  });
  afterEach(^{
    _appDelegate = nil;
  });
});

SpecEnd

