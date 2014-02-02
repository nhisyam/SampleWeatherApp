#import "NHMAppDelegate.h"
#import "WXController.h"
#import <TSMessages/TSMessage.h>

@implementation NHMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  WXController *rootViewController = [[WXController alloc] init];
  self.rootViewController = rootViewController;
  
  [self.window setRootViewController:self.rootViewController];
  
  [TSMessage setDefaultViewController:self.window.rootViewController];
  
  return YES;
}

@end
