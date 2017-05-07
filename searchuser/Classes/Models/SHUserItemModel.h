//
//  SHUserItemModel.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHModel.h"

@interface SHUserItemModel : SHModel
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *reposUrl;

@property (nonatomic, copy) NSString *preferredLanguage;

@end
