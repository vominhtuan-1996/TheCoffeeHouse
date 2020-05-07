//
//  ChangedPageViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/31/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "ChangedPageViewController.h"
#import "WaterViewController.h"
#import "FoodViewController.h"
#import "CakesViewController.h"

@interface ChangedPageViewController ()

@end

@implementation ChangedPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Đặt hàng";
    // Do any additional setup after loading the view.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = self.containerView.bounds;
    WaterViewController *initViewController = (WaterViewController  *)[self viewControllerAtindex:0];
    NSArray *viewControlers = [NSArray arrayWithObject:initViewController];
    [self.pageViewController setViewControllers:viewControlers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.containerView addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.lineView setFrame:CGRectMake(0, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
    [self.lineView layoutIfNeeded];
}
#pragma mark - Action

- (IBAction)selectedButtonIndex0:(id)sender {
    self.index = 0;
    WaterViewController *initVC = (WaterViewController *)[self viewControllerAtindex:self.index];
    [self.pageViewController setViewControllers:@[initVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [UIView animateWithDuration:0.2 animations:^{
        [self.lineView setFrame:CGRectMake(0, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
        [self.lineView setNeedsLayout];
    }];
}
- (IBAction)selectedButtonIndex1:(id)sender {
    self.index = 1;
    FoodViewController *initVC = (FoodViewController *)[self viewControllerAtindex:self.index];
    [self.pageViewController setViewControllers:@[initVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width/3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
        [self.lineView setNeedsLayout];
    }];
    
}
- (IBAction)selectedButtonIndex2:(id)sender {
    self.index = 2;
    CakesViewController *initVC = (CakesViewController *)[self viewControllerAtindex:self.index];
    [self.pageViewController setViewControllers:@[initVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width*2 / 3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
        [self.lineView setNeedsLayout];
    }];
   
}
#pragma mark - UIPageViewControllerDataSource

- (UIViewController *) viewControllerAtindex:(NSUInteger)index {
   
    if (index == 0) {
       WaterViewController * viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"WaterViewController"];
        viewcontroller.index = index;
        return  viewcontroller;
    } else if (index == 1) {
        FoodViewController *  viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"FoodViewController"];
        viewcontroller.index = index;
        return viewcontroller;
    } else {
        CakesViewController*   viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"CakesViewController"];
        viewcontroller.index = index;
        return viewcontroller;
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((ChangedPageViewController *)viewController).index;
    if (index == 0 || index == NSNotFound) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(0, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
        return  nil;
    } else if (index == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width/3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width*2 / 3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
        
    }
    index --;
    return [self viewControllerAtindex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ChangedPageViewController *) viewController).index;
    if (index == NSNotFound) {
        return nil;
    } else if (index == 2) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width*2 / 3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
    } else if (index == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(self.headerView.frame.size.width/3, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.lineView setFrame:CGRectMake(0, self.headerView.frame.size.height - 1, self.headerView.frame.size.width/3, 1)];
            [self.lineView layoutIfNeeded];
        }];
    }
    index ++;
    if (index == 3) {
        return nil;
    }
    return [self viewControllerAtindex:index];
}


@end
