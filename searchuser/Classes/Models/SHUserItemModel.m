//
//  SHUserItemModel.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHUserItemModel.h"

@implementation SHUserItemModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"login" : @"login",
            @"avatarUrl" : @"avatar_url",
            @"reposUrl" : @"repos_url",
            }];
}

@end
