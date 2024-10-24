//
//  User.m
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/24.
//

#import "User.h"

@implementation User
- (instancetype)initWithFirstname:(NSString *)firstname
                         lastName:(NSString *)lastName
                            email:(NSString *)email
                              age:(NSInteger)age {
    self = [super init];
    if (self) {
        _firstname = firstname;
        _lastName = lastName;
        _email = email;
        _age = age;
    }
    return self;
}
@end
