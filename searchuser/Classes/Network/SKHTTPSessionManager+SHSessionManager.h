//
//  SKHTTPSessionManager+SHSessionManager.h
//  searchuser
//
//  Created by shuu on 2017/5/5.
//  Copyright © 2017年 shuu. All rights reserved.
//

#import <StarterKit/SKHTTPSessionManager.h>

@interface SKHTTPSessionManager (SHSessionManager)

- (AnyPromise *)searchUsers:(NSDictionary *)parameters;

- (AnyPromise *)fetchReposWithUser:(NSString *)user parameters:(NSDictionary *)parameters;

@end
