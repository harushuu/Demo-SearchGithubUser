//
//  SHUserListTableViewCell.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHUserListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SHUserListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
    
  }
  return self;
}

- (void)configureCellWithData:(SHUserItemModel *)data {
  [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.avatarUrl] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
  self.textLabel.text = data.login;
  self.detailTextLabel.text = data.preferredLanguage.length ? data.preferredLanguage : kCheckPreferredLanguageKey;
  [self updateConstraintsIfNeeded];
  [self setNeedsUpdateConstraints];
}

+ (NSString *)cellIdentifier {
  static NSString * const kCellIdentifier = @"SHUserListTableViewCell";
  return kCellIdentifier;
}


@end
