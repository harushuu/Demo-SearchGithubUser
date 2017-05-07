//
//  SHLoadingHudManager.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHLoadingHudManager.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SHLoadingHudManager ()
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation SHLoadingHudManager

+ (SHLoadingHudManager *)sharedManager {
  static SHLoadingHudManager *_sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedManager = [[SHLoadingHudManager alloc] init];
  });
  return _sharedManager;
}

+ (void)showHUD {
  SHLoadingHudManager *hudManager = [SHLoadingHudManager sharedManager];
  if (hudManager.progressHUD.superview) {
    [SHLoadingHudManager hideHUD];
  }
  hudManager.progressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
  
  [[UIApplication sharedApplication].keyWindow addSubview:hudManager.progressHUD];
  [hudManager.progressHUD showAnimated:YES];
}

+ (void)hideHUD {
  SHLoadingHudManager *hudManager = [SHLoadingHudManager sharedManager];
  [hudManager.progressHUD hideAnimated:YES];
  [hudManager.progressHUD removeFromSuperview];
}

- (MBProgressHUD *)progressHUD {
  if (!_progressHUD) {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _progressHUD = [[MBProgressHUD alloc] initWithView:window];
  }
  return _progressHUD;
}

@end
