//
//  LocationGPS+CoreDataProperties.m
//  
//
//  Created by VoMinhTuanIOS on 11/12/19.
//
//

#import "LocationGPS+CoreDataProperties.h"

@implementation LocationGPS (CoreDataProperties)

+ (NSFetchRequest<LocationGPS *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"LocationGPS"];
}

@dynamic address;
@dynamic dictrict;
@dynamic fullname;
@dynamic image;
@dynamic latitube;
@dynamic longtitube;
@dynamic title;

@end
