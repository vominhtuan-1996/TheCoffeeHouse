//
//  LoginViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/11/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
#import "Define.h"

@interface LoginViewController ()<UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainWidthButtonGoogle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraiWidthButtonFaceBook;
//@property (assign , nonatomic) BOOL isShowController;
@property (retain, nonatomic) FBSDKLoginButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.avatarImage.contentMode =  UIViewContentModeScaleToFill;
    self.mainView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mainView.layer.borderWidth = 0.3;
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//
    self.shadowView.layer.shadowRadius = 5;
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowOffset = CGSizeMake(5,5);
    self.shadowView.layer.cornerRadius = 5;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    
     self.loginButton = [[FBSDKLoginButton alloc] init];
     self.loginButton.hidden = YES;
    self.faceBookView.layer.borderWidth = 0.5;
    self.faceBookView.layer.cornerRadius = 10;
    self.faceBookView.layer.masksToBounds= YES;
    [self.loginButton addTarget:self action:@selector(loginFaceBookButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.faceBookView.backgroundColor = [UIColor blueColor];
    self.googleView.alpha = 2;
    
    int widthButton;
    if (SCREEN_WIDTH <= 320 ) {
        widthButton = SCREEN_WIDTH - 60;
    } else {
        widthButton = SCREEN_WIDTH - 120;
    }
    self.constraiWidthButtonFaceBook.constant = widthButton;
    self.constrainWidthButtonGoogle.constant = widthButton;
    

    UITapGestureRecognizer *loginCustomFaceBookButtonClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginCustomFaceBookButtonClick:)];
    [self.faceBookView addGestureRecognizer:loginCustomFaceBookButtonClick];
    
    [GIDSignIn sharedInstance].presentingViewController = self;
    self.googleView.layer.borderWidth = 0.5;
    self.googleView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.googleView.backgroundColor = [UIColor redColor];
    self.googleView.alpha = 0.8;
    self.googleView.layer.cornerRadius = 10;
    self.googleView.layer.masksToBounds = YES;
    UITapGestureRecognizer *googleButtonClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(googleButtonClick:)];
    [self.googleView addGestureRecognizer:googleButtonClick];
}

#pragma mark - Method

- (void)loginCustomFaceBookButtonClick : sender {
    [self.loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

- (void)googleButtonClick:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

- (void)loginFaceBookButtonClick: sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* controller = [storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - FBSDKloginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(nullable FBSDKLoginManagerLoginResult *)result
              error:(nullable NSError *)error {
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    if (result.isCancelled) {
        NSLog(@"User cancelled the login.");
    } else if (result.declinedPermissions.count > 0) {
        NSLog(@"User has declined the permission.");
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"User logged Out. ");
}
@end
