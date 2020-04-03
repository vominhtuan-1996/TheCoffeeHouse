//
//  AccountTableViewCell.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/14/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AccountTableViewCell;
@protocol AccountTableViewCellDelegate <NSObject,UIGestureRecognizerDelegate>

@optional
- (void)tapgesAction:(int) index;
@end
@interface AccountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (assign, nonatomic) id<AccountTableViewCellDelegate> delegate;
@property (assign, nonatomic) int index;

- (void)setDataWithImage:(UIImage *)image name:(NSString *)fullname;
@end

NS_ASSUME_NONNULL_END
