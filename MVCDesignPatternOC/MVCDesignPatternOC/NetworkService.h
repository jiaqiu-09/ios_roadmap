//
//  NetworkService.h
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/24.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject
@property (nonatomic, strong, readonly) User * currentUser;

+ (instancetype)sharedInstance;

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(void (^)(BOOL success)) completion;
@end

NS_ASSUME_NONNULL_END
