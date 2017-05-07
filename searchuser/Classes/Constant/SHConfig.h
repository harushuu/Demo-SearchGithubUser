//
//  SHConfig.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHConfig : NSObject

extern NSString * const kBaseURL;
extern NSString * const kAccept;

extern NSUInteger const kPerPage;
extern NSString * const kParamPageSize;

extern NSString * const kSearchPlaceholder;

extern NSString * const kSearchUserKey;
extern NSString * const kFetchUserReposKey;
extern NSString * const kCheckPreferredLanguageKey;
extern NSString * const kPreferredLanguageKey;


@end
