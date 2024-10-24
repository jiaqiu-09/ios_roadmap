//
//  HomePageViewController.m
//  MVCDesignPatternOC
//
//  Created by Jason Qiu on 2024/10/24.
//

#import "HomePageViewController.h"
#import "NetworkService.h"

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.welcomeLabel.text = [NSString stringWithFormat:@"%@ %@",[NetworkService sharedInstance].currentUser.lastName, [NetworkService sharedInstance].currentUser.firstname];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
