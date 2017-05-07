//
//  SHRepoModel.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHModel.h"
#import "SHUserItemModel.h"

@interface SHRepoModel : SHModel
@property (nonatomic, strong) SHUserItemModel *owner;
@property (nonatomic, copy) NSString *language;

@end
