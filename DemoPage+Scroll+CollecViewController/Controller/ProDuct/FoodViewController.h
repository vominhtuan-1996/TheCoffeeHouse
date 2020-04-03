//
//  FoodViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) NSUInteger index;
@end

NS_ASSUME_NONNULL_END
