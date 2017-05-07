//
//  SHUserListTableViewCell.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHTableViewCell.h"
#import "SHUserItemModel.h"

@interface SHUserListTableViewCell : SHTableViewCell

- (void)configureCellWithData:(SHUserItemModel *)data;

+ (NSString *)cellIdentifier;

@end
