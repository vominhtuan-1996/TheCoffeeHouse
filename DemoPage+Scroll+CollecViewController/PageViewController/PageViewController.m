//
//  PageViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "PageViewController.h"
#import "WaterViewController.h"

@interface PageViewController ()
@property (assign , nonatomic) NSUInteger currentPage;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    self.currentPage = 0;
    WaterViewController *initViewController = (WaterViewController  *)[self viewControllerAtindex:0];
    NSArray *viewControlers = [NSArray arrayWithObject:initViewController];
    [self setViewControllers:viewControlers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *) viewControllerAtindex:(NSUInteger)index {
    WaterViewController *viewcontroller ;
    
    if (index == 0) {
        viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"WaterViewController"];
        viewcontroller.index = index;
    } else
        if (index == 1) {
            viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"FoodViewController"];
            viewcontroller.index = index;
        } else
            if (index == 2) {
                viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"CakesViewController"];
                viewcontroller.index = index;
            }
    
    return viewcontroller;
}
                                               
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((WaterViewController *)viewController).index;
    if (index == 0 || index == NSNotFound) {
        return  nil;
    }
    index --;
    return [self viewControllerAtindex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((WaterViewController *) viewController).index;
    if (index == NSNotFound) {
        return nil;
    }
    index ++;
    if (index == 3) {
        return nil;
    }
    return [self viewControllerAtindex:index];
}


@end
