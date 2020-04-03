//
//  AddressCollectionViewCell.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/5/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "AddressCollectionViewCell.h"

@implementation AddressCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addressImage.contentMode = UIViewContentModeScaleAspectFill;
    self.mainView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mainView.layer.borderWidth = 0.3;
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *cell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddress:)];
    [self addGestureRecognizer:cell];
}
-(void)selectAddress:(UITapGestureRecognizer *) index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress:)]) {
        [self.delegate selectAddress:self.index];
    }
}

- (void)setDataWithImage:(UIImage *)image dictrict:(NSString *)dictrict address:(NSString *)address {
    self.addressImage.image = image;
    self.dictrictLabel.text = dictrict;
    self.addressLabel.text = address;
}
- (void)setDataWithObject:(LocationGPS *)locationObject {
    self.addressImage.image = [UIImage imageNamed:locationObject.image];
    self.dictrictLabel.text = locationObject.address;
    self.addressLabel.text = locationObject.dictrict;
}
@end
