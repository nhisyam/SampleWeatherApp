#import <UIKit/UIKit.h>

extern BOOL viewDidLoadOverrideWasCalled;
extern BOOL viewWillLayoutSubviewsWasCalled;

@interface UIViewController (ForTesting)
- (void)viewDidLoadOverride;
- (void)viewWillLayoutSubviewsOverride;
@end
