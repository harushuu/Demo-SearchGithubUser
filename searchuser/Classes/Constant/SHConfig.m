//
//  SHConfig.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHConfig.h"

@implementation SHConfig

NSString * const kBaseURL = @"https://api.github.com/";
NSString * const kAccept = @"application/vnd.github.mercy-preview+json";

NSUInteger const kPerPage = 100;
NSString * const kParamPageSize = @"per_page";
NSString * const kParamPageIndex = @"page";
NSUInteger const kStartPageIndex = 1;
NSString * const kTokenKey = @"b23646c039866dea744cf1ad4346207f2e462e80";
NSString * const kParamTokenKey = @"access_token";

NSString * const kSearchPlaceholder = @"请输入关键字搜索";

NSString * const kSearchUserKey = @"q";
NSString * const kFetchUserReposKey = @"kFetchUserReposKey";
NSString * const kCheckPreferredLanguageKey = @"请点击查看偏好语言";
NSString * const kPreferredLanguageKey = @"偏好语言";

@end
