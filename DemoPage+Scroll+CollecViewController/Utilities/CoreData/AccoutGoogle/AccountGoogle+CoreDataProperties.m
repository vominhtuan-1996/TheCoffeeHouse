//
//  AccountGoogle+CoreDataProperties.m
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "AccountGoogle+CoreDataProperties.h"

@implementation AccountGoogle (CoreDataProperties)

+ (NSFetchRequest<AccountGoogle *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AccountGoogle"];
}

@dynamic idToken;
@dynamic fullname;
@dynamic image;
@dynamic email;

@end
