//
//  ShoppingViewController.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/21/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
