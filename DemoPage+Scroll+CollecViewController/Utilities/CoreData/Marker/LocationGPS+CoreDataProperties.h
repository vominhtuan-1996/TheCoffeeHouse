//
//  LocationGPS+CoreDataProperties.h
//  
//
//  Created by VoMinhTuanIOS on 11/12/19.
//
//

#import "LocationGPS+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LocationGPS (CoreDataProperties)

+ (NSFetchRequest<LocationGPS *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *dictrict;
@property (nullable, nonatomic, copy) NSString *fullname;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *latitube;
@property (nullable, nonatomic, copy) NSString *longtitube;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
