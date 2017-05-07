//
//  SKHTTPSessionManager+SHSessionManager.m
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import "SKHTTPSessionManager+SHSessionManager.h"

static NSString * const kSearchUsersKey = @"/search/users";
static NSString * const kFetchReposKey = @"/users/*/repos";

@implementation SKHTTPSessionManager (SHSessionManager)

- (AnyPromise *)searchUsers:(NSDictionary *)parameters {
  return [self pmk_GET:@"/search/users" parameters:parameters];
}

- (AnyPromise *)fetchReposWithUser:(NSString *)user parameters:(NSDictionary *)parameters {
  NSString *searchReposUrl = [kFetchReposKey stringByReplacingOccurrencesOfString:@"*" withString:user];
  return [self pmk_GET:searchReposUrl parameters:parameters];
}

+ (NSDictionary *)modelClassesByResourcePath {
  return @{kSearchUsersKey : NSClassFromString(@"SHUserModel"),
           kFetchReposKey : NSClassFromString(@"SHRepoModel"),
           };
}


@end
