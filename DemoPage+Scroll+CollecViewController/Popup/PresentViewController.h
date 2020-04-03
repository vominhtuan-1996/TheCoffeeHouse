//
//  PresentViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/31/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PresentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *bigButton;
@property (weak, nonatomic) IBOutlet UIButton *smallButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *price;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSString *image;
@property (weak, nonatomic) IBOutlet UIButton *sumButton;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (strong, nonatomic) Food * objectFoodVC;
@property (assign, nonatomic) int idFood;


@end

NS_ASSUME_NONNULL_END
