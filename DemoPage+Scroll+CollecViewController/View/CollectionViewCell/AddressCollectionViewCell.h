//
//  AddressCollectionViewCell.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/5/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationGPS+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN
@class AddressCollectionViewCell;
@protocol AddressCollectionViewCellDelagate <NSObject , UIGestureRecognizerDelegate>

@optional

-(void)selectAddress:(int) index;

@end

@interface AddressCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *addressImage;
@property (weak, nonatomic) IBOutlet UILabel *dictrictLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (assign, nonatomic) int index;
@property (assign, nonatomic) id <AddressCollectionViewCellDelagate> delegate;
@property (strong, nonatomic) LocationGPS *objectGPS;

- (void)setDataWithImage:(UIImage *)image dictrict:(NSString *)dictrict address:(NSString *)address;
- (void)setDataWithObject:(LocationGPS *) locationObject;
@end

NS_ASSUME_NONNULL_END
