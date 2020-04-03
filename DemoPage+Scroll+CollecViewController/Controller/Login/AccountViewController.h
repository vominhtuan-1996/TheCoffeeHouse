//
//  AccountViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/13/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *fullnameStr;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *nameArray;
@property (assign, nonatomic)  NSURL *url;
@property (strong, nonatomic) IBOutlet UIView *mainView;


@end

NS_ASSUME_NONNULL_END
