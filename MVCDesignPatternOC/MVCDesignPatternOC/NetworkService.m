//
//  NetworkService.m
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/24.
//

#import "NetworkService.h"

@interface NetworkService ()

@property (nonatomic, strong) User *currentUser;

@end

@implementation NetworkService

+ (instancetype)sharedInstance {
    static NetworkService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(void (^)(BOOL success))completion {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([email isEqualToString:@"test@test.com"] && [password isEqualToString:@"password"]) {
            self.currentUser = [[User alloc] initWithFirstname:@"Qiu" lastName:@"Jason" email:email age:30];
            completion(YES);
        } else {
            completion(NO);
        }
    });
}
@end
