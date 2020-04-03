//
//  Food+CoreDataProperties.m
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "Food+CoreDataProperties.h"

@implementation Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Food"];
}

@dynamic fullname;
@dynamic idFood;
@dynamic image;
@dynamic price;
@dynamic type;

@end
