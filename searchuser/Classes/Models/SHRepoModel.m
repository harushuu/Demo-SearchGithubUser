//
//  SHRepoModel.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHRepoModel.h"

@implementation SHRepoModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"owner" : @"owner",
            @"language" : @"language",
            }];
}

+ (NSValueTransformer *)ownerJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SHUserItemModel class]];
}

@end
