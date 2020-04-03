//
//  Shopping+CoreDataProperties.h
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "Shopping+CoreDataClass.h"
#import "ShoppingCart.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shopping (CoreDataProperties)

+ (NSFetchRequest<Shopping *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fullname;
@property (nonatomic) int32_t idsanpham;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *soluong;
@property (nullable, nonatomic, copy) NSString *sumprice;
@property (nullable, nonatomic, copy) NSString *price;

- (ShoppingCart *)convertToShoppingCart;
  
@end

NS_ASSUME_NONNULL_END
