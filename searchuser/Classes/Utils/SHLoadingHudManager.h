//
//  SHLoadingHudManager.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HIDE_HUD [SHLoadingHudManager hideHUD];

#define SHOW_HUD [SHLoadingHudManager showHUD];

@interface SHLoadingHudManager : NSObject

+ (void)showHUD;

+ (void)hideHUD;

@end
