//
//  AccountTableViewCell.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/14/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *cell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapgesAction:)];
    [self addGestureRecognizer:cell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithImage:(UIImage *)image name:(NSString *)fullname {
    self.avatarImageView.image = image;
    self.fullnameLabel.text = fullname;
}

- (void)tapgesAction:(UITapGestureRecognizer *) index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapgesAction:)]) {
        [self.delegate tapgesAction:self.index];
    }
}
@end
