//
//  Shopping+CoreDataProperties.m
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "Shopping+CoreDataProperties.h"

@implementation Shopping (CoreDataProperties)

+ (NSFetchRequest<Shopping *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Shopping"];
}

@dynamic fullname;
@dynamic idsanpham;
@dynamic image;
@dynamic soluong;
@dynamic sumprice;
@dynamic price;


- (ShoppingCart *)convertToShoppingCart {
    ShoppingCart * shopingObj = [[ShoppingCart alloc] init];
    shopingObj.fullname = self.fullname;
    shopingObj.idsanpham = self.idsanpham;
    shopingObj.image = self.image;
    shopingObj.soluong = self.soluong;
    shopingObj.sumprice = self.sumprice;
    shopingObj.price = self.price;
    
    return shopingObj;
}
@end
