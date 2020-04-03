//
//  ShoppingCart.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/22/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCart : NSObject

@property (nullable, nonatomic, copy) NSString *fullname;
@property (nonatomic) int32_t idsanpham;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *soluong;
@property (nullable, nonatomic, copy) NSString *sumprice;
@property (nullable, nonatomic, copy) NSString *price;
@property (assign, nonatomic) BOOL isCounted;

@end

NS_ASSUME_NONNULL_END
