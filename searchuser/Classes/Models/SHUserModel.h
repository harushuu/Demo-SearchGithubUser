//
//  SHUserModel.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHModel.h"
#import "SHUserItemModel.h"

@interface SHUserModel : SHModel
@property (nonatomic, strong) NSArray<SHUserItemModel *> *items;

@end
