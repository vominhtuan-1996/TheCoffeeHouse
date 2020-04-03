//
//  WaterViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterViewController : UIViewController<UICollectionViewDelegate , UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign , nonatomic) NSUInteger index;
//@property (weak, nonatomic) id<WaterViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
