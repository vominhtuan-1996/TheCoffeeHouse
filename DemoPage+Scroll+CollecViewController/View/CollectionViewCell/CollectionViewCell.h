//
//  CollectionViewCell.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN
@class CollectionViewCell;
@protocol CollectionViewCellDelegate <NSObject>

@optional

- (void)showViewpresent:(NSUInteger) index;

@end

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *showPopupButton;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) id <CollectionViewCellDelegate> delegate;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) Food *objectFood;


- (void)setDataWithImage:(UIImage *)image infoLabel:(NSString *)infoLabel priceLabel:(NSString *)priceLabel;

- (void)setDataWithObject:(Food *) FoodObject type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
