//
//  ShopTableViewCell.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/5/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *cell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCell:)];
    [self addGestureRecognizer:cell];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataWithAddress:(NSString *)address {
    self.addressLabel.text = address;
}
- (void)setdataWithObject:(LocationGPS *)objectLocation {
    self.addressLabel.text = objectLocation.address;
}
- (void)hiddenCell:(UITapGestureRecognizer *) index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenCell:)]) {
        [self.delegate hiddenCell:self.index];
    }
}
@end
