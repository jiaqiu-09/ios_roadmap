//
//  ViewController.m
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/23.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "HomePageViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton * loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameField.placeholder = @"Please enter username";
    self.usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.passwordField.placeholder = @"Please enter your password";
    self.passwordField.secureTextEntry = YES;

    
    [self.usernameField addTarget:self action:@selector(validateTextField) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(validateTextField) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)validateTextField {
    [self.loginButton setEnabled:![self.usernameField.text isEqual: @""] && ![self.passwordField.text isEqual: @""]];
}

- (IBAction)buttonClicked:(id)sender {
    NSLog(@"Username is %@, password is %@", self.usernameField.text, self.passwordField.text);
    [[NetworkService sharedInstance] loginWithEmail:self.usernameField.text password:self.passwordField.text completion:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self navigateToHomePage];
                });
            } else {
                NSLog(@"Login failed!");
            }
    }];
}

- (void)navigateToHomePage {
    // 获取 Storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 实例化 HomePageViewController
    HomePageViewController *homePageVC = [storyboard instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    
    // 推送到 HomePageViewController
    [self.navigationController pushViewController:homePageVC animated:YES];
}

@end
