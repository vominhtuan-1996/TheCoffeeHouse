//
//  ChangedPageViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/31/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangedPageViewController : UIViewController<UIPageViewControllerDataSource , UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

NS_ASSUME_NONNULL_END
