//
//  CollectionViewCell.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "CollectionViewCell.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    self.mainView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mainView.layer.borderWidth = 0.3;
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.backgroundColor = [UIColor whiteColor].CGColor;

    self.shadowView.layer.shadowRadius = 5;
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowOffset = CGSizeMake(1.5, 3);
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowColor = [UIColor purpleColor].CGColor;
   // self.shadowView.layer.backgroundColor = [UIColor purpleColor].CGColor;
    
    
    self.priceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.priceLabel.numberOfLines = 0;

}

- (void)setDataWithImage:(UIImage *)image infoLabel:(NSString *)infoLabel priceLabel:(NSString *)priceLabel {
    self.avatarImage.image = image;
    self.infoLabel.text = infoLabel;
    self.priceLabel.text = priceLabel;
    
}

- (void)setDataWithObject:(Food *)FoodObject type:(NSString *) type {
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    //if (FoodObject.type == type) {
//      NSManagedObject *newData = FoodObject;
   if ([FoodObject.type isEqualToString:type]) {
        self.avatarImage.image =[UIImage imageNamed:FoodObject.image] ;
        self.infoLabel.text = FoodObject.fullname;
        self.priceLabel.text = FoodObject.price;
   }
    
  
}

- (IBAction)showViewpresent:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showViewpresent:)]) {
        [self.delegate showViewpresent:self.index];
    }
}

@end
