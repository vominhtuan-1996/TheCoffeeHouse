//
//  ShoppingTableViewCell.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/21/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shopping+CoreDataClass.h"
#import "ShoppingCart.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *soluongLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumpriceLabel;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) Shopping *objectShopping;

- (void)setDataWithObject:(ShoppingCart *) ShoppingObject;
@end

NS_ASSUME_NONNULL_END
