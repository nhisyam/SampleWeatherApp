#import "UIViewController+ForTesting.h"

BOOL viewDidLoadOverrideWasCalled;
BOOL viewWillLayoutSubviewsWasCalled;

@implementation UIViewController (ForTesting)

- (void)viewDidLoadOverride {
  [self viewDidLoadOverride];
  viewDidLoadOverrideWasCalled = YES;
}

- (void)viewWillLayoutSubviewsOverride {
  [self viewWillLayoutSubviewsOverride];
  viewWillLayoutSubviewsWasCalled = YES;
}
@end
