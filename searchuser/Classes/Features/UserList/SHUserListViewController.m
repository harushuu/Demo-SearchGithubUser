//
//  SHUserListViewController.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SHUserListViewController.h"
#import "SHUserListTableViewCell.h"
#import "SHUserModel.h"
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <StarterKit/SKToastUtil.h>
#import <Overcoat/OVCResponse.h>
#import "SHRepoModel.h"

@interface SHUserListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) SHUserModel *searchResult;
@property (nonatomic, strong) NSMutableArray<SHUserItemModel *> *searchUsers;

@end

@implementation SHUserListViewController

#pragma mark - life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
  [self.view setNeedsUpdateConstraints];
  [self.view updateConstraintsIfNeeded];
}

- (void)setupTableView {
  [self.tableView registerClass:[SHUserListTableViewCell class] forCellReuseIdentifier:[SHUserListTableViewCell cellIdentifier]];
  [self.view addSubview:self.tableView];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  self.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);
  self.tableView.tableHeaderView = self.searchBar;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.searchUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SHUserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SHUserListTableViewCell cellIdentifier]];
  [self configuerCell:cell indexPath:indexPath];
  return cell;
}

- (void)configuerCell:(SHUserListTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
  SHUserItemModel *cellData = self.searchUsers[indexPath.row];
  [cell configureCellWithData:cellData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat cellHeight = [self.tableView fd_heightForCellWithIdentifier:[SHUserListTableViewCell cellIdentifier] cacheByIndexPath:indexPath configuration:^(SHUserListTableViewCell *cell) {
    [self configuerCell:cell indexPath:indexPath];
  }];
  return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.view endEditing:YES];
  [self fetchReposWithIndexPath:indexPath];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  if (!searchText.length) {
    [self.searchUsers removeAllObjects];
    [self.tableView reloadData];
    return;
  }
  if (searchText.length == 1 && [[searchText substringToIndex:1] isEqualToString:@" "]) {
    searchBar.text = @"";
    return;
  }
  
  [self searchUserWithText:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self.view endEditing:YES];
}

#pragma mark - SearchUser API

- (void)searchUserWithText:(NSString *)searchText {
  NSDictionary *param = @{kSearchUserKey : searchText,
                          kParamPageSize : @(kPerPage)};
  [self.sessionManager searchUsers:param].then(^(OVCResponse *response) {
    [self buildUserData:response.result];
    [self.tableView reloadData];
  }).catch(^(NSError *error) {
    [SKToastUtil toastWithText:error.localizedDescription];
  }).always(^{
  });
}

- (void)fetchReposWithIndexPath:(NSIndexPath *)indexPath {
  SHUserItemModel *user = self.searchUsers[indexPath.row];
  
  if (user.preferredLanguage.length) {
    return;
  }
  
  SHOW_HUD
  NSDictionary *param = @{kParamPageSize : @(kPerPage)};
  [self.sessionManager fetchReposWithUser:user.login parameters:param].then(^(OVCResponse *response) {
    user.preferredLanguage = [self statisticsPreferredLanguage:response.result];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  }).catch(^(NSError *error) {
    [SKToastUtil toastWithText:error.localizedDescription];
  }).always(^{
    HIDE_HUD
  });
}

#pragma mark - Build Data

- (void)buildUserData:(SHUserModel *)userData {
  self.searchResult = userData;
  self.searchUsers = userData.items.mutableCopy;
}

- (NSString *)statisticsPreferredLanguage:(NSArray<SHRepoModel *> *)userRepos {
  if (!userRepos.count) {
    return @"";
  }
  
  __block NSMutableDictionary *languagesDictionary = @{}.mutableCopy;
  
  [userRepos enumerateObjectsUsingBlock:^(SHRepoModel * _Nonnull repo, NSUInteger idx, BOOL * _Nonnull stop) {
    if (repo.language.length) {
      NSNumber *languagesCount = languagesDictionary[repo.language];
      languagesCount =  (!languagesCount || languagesCount.integerValue == 0) ? @1 : @(languagesCount.integerValue + 1);
      languagesDictionary[repo.language] = languagesCount;
    }
  }];

  if (!languagesDictionary.count) {
    return @"";
  }
  
  NSArray<NSString *> *languagesDictionaryKeys = languagesDictionary.allKeys;
  NSMutableSet<NSString *> *allLanguagesSet = [NSMutableSet set];
  allLanguagesSet = [NSMutableSet setWithArray:languagesDictionaryKeys];
  NSMutableArray *allLanguagesArray = [allLanguagesSet allObjects].mutableCopy;

  [allLanguagesArray sortUsingComparator:^NSComparisonResult(NSString *  _Nonnull key1, NSString *  _Nonnull key2) {
    NSNumber *key1Count = languagesDictionary[key1];
    NSNumber *key2Count = languagesDictionary[key2];
    return key1Count.integerValue < key2Count.integerValue;
  }];
  
  NSMutableArray<NSString *> *preferredLanguagesArray = @[].mutableCopy;

  [allLanguagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull language, NSUInteger idx, BOOL * _Nonnull stop) {
    
    if (!preferredLanguagesArray.count) {
      [preferredLanguagesArray addObject:language];
    } else {
      NSNumber *key1Count = languagesDictionary[language];
      NSNumber *key2Count = languagesDictionary[preferredLanguagesArray.lastObject];
      if (key1Count >= key2Count) {
        [preferredLanguagesArray addObject:language];
      }
      if (key1Count < key2Count) {
        *stop = YES;
      }
    }
    
  }];
  
  __block NSString *preferredLanguage = @"";
  
  [preferredLanguagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull language, NSUInteger idx, BOOL * _Nonnull stop) {
    if (!preferredLanguage.length) {
      preferredLanguage = kPreferredLanguageKey;
    }
    
    preferredLanguage = [NSString stringWithFormat:@"%@ %@", preferredLanguage, language];
    
    if (idx != preferredLanguagesArray.count - 1) {
      preferredLanguage = [preferredLanguage stringByAppendingString:@"、"];
    }
    if (idx == preferredLanguagesArray.count - 1) {
      NSNumber *key1Count = languagesDictionary[preferredLanguagesArray.lastObject];
      NSInteger totalCount = userRepos.count;
      CGFloat percent = key1Count.floatValue / totalCount * 100;
      preferredLanguage = [NSString stringWithFormat:@"%@ %.2f%%", preferredLanguage, percent];
    }
  }];
 
  return preferredLanguage;
}

#pragma mark - getter

- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  }
  return _tableView;
}

- (UISearchBar *)searchBar {
  if (!_searchBar) {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = kSearchPlaceholder;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeyDone;
  }
  return _searchBar;
}

- (NSMutableArray *)searchUsers {
  if (!_searchUsers) {
    _searchUsers = @[].mutableCopy;
  }
  return _searchUsers;
}

@end
