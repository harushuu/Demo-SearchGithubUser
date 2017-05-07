//
//  SHViewController.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHViewController.h"

@interface SHViewController ()

@end

@implementation SHViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (SKHTTPSessionManager *)sessionManager {
  if (!_sessionManager) {
    _sessionManager = [[SKHTTPSessionManager alloc] init];
  }
  return _sessionManager;
}

@end
