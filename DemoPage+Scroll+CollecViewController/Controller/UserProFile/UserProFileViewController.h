//
//  UserProFileViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/18/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProFileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberLabel;

@property (strong, nonatomic) NSString *fullname;
@property (strong, nonatomic) NSString *phonenumber;
@property (strong, nonatomic) NSString *birthday;
@property (assign, nonatomic) NSURL *urlImage;

@end

NS_ASSUME_NONNULL_END
