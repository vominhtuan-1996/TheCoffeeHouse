//
//  AccountGoogle+CoreDataProperties.h
//  
//
//  Created by VoMinhTuanIOS on 11/21/19.
//
//

#import "AccountGoogle+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AccountGoogle (CoreDataProperties)

+ (NSFetchRequest<AccountGoogle *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idToken;
@property (nullable, nonatomic, copy) NSString *fullname;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *email;

@end

NS_ASSUME_NONNULL_END
