//
//  ShoppingTableViewCell.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/21/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "ShoppingTableViewCell.h"

@implementation ShoppingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initlayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initlayout {
    self.productImage.contentMode = UIViewContentModeScaleAspectFill;
    self.productImage.layer.cornerRadius = 10;
    self.productImage.layer.masksToBounds = YES;
    
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 10;
    
    self.shadowView.backgroundColor = [UIColor whiteColor];
    self.shadowView.layer.shadowRadius = 5;
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowOffset = CGSizeMake(1.5, 3);
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
}
- (void)setDataWithObject:(ShoppingCart *)ShoppingObject {
    self.fullnameLabel.text = ShoppingObject.fullname;
    self.priceLabel.text = ShoppingObject.price;
    self.productImage.image =[UIImage imageNamed:ShoppingObject.image];
    self.soluongLabel.text = ShoppingObject.soluong;
    self.sumpriceLabel.text = ShoppingObject.sumprice;
}

@end
