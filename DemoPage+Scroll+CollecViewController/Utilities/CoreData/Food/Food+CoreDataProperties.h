//
//  Food+CoreDataProperties.h
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "Food+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fullname;
@property (nonatomic) int32_t idFood;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
