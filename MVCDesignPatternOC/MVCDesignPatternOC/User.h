//
//  User.h
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithFirstname:(NSString *)firstname
                         lastName:(NSString *)lastName
                            email:(NSString *)email
                              age:(NSInteger)age;
@end

NS_ASSUME_NONNULL_END
