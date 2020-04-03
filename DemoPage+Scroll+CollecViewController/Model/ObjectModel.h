//
//  ObjectModel.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/31/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectModel : NSObject
@property (strong, nonatomic) NSString* imageView;
@property (strong, nonatomic) NSString* info;
@property (strong, nonatomic) NSString* price;

- (void)parseDataFromDictionary:(NSDictionary *)dict ;

@end

NS_ASSUME_NONNULL_END
