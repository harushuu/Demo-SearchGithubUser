//
//  SHUserModel.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHUserModel.h"

@implementation SHUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"items" : @"items",
            }];
}

+ (NSValueTransformer *)itemsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SHUserItemModel class]];
}

@end
