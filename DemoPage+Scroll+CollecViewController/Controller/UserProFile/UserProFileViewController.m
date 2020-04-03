//
//  UserProFileViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/18/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "UserProFileViewController.h"
#import "AccountViewController.h"

@interface UserProFileViewController ()
@end

@implementation UserProFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initlayout];
    self.fullnameLabel.text = self.fullname;
    self.nameLabel.text = self.fullname;
    self.birthdayLabel.text = self.birthday;
    self.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlImage]];
    self.birthdayLabel.text = self.birthday;
}

- (void)initlayout {
    self.cancelButton.layer.cornerRadius = 15;
    self.cancelButton.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2;
   
}

- (IBAction)cancleButtonClick:(id)sender {
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *controller = [storyboard instantiateViewControllerWithIdentifier:@"TabbarController"];
//    [self presentViewController:controller animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
