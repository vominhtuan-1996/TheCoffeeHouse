//
//  ShopTableViewCell.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/5/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "LocationGPS+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN
@class ShopTableViewCell;
@protocol ShopTableViewCellDelegate <NSObject,UIGestureRecognizerDelegate>

@optional
- (void)hiddenCell:(int) index;
@end
@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (assign, nonatomic) int index;
@property (assign, nonatomic) id<ShopTableViewCellDelegate>delegate;
@property (strong, nonatomic) LocationGPS *objectGPS;

-(void)setDataWithAddress:(NSString*)address;
- (void)setdataWithObject:(LocationGPS *) objectLocation;
@end

NS_ASSUME_NONNULL_END
