//
//  PresentViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/31/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "PresentViewController.h"
#import "Shopping+CoreDataClass.h"
#import "AppDelegate.h"
#import "ShoppingViewController.h"

@interface PresentViewController ()
@property (assign, nonatomic) BOOL status;
@property (assign, nonatomic) int sumPrice;
@property (assign, nonatomic) int object;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.removeButton.layer.cornerRadius = self.removeButton.frame.size.height/2;
    self.removeButton.layer.borderWidth = 0.5;
    self.removeButton.layer.masksToBounds = YES;
    self.removeButton.backgroundColor = [UIColor orangeColor];
    
    self.addButton.layer.masksToBounds = YES;
    self.addButton.layer.cornerRadius = self.addButton.frame.size.height/2;
    self.addButton.layer.borderWidth = 0.5 ;
    self.addButton.backgroundColor = [UIColor orangeColor];
    
    
    self.bigButton.layer.masksToBounds = YES;
    self.bigButton.layer.cornerRadius = self.bigButton.frame.size.height/2;
    self.bigButton.layer.borderWidth = 0.5;
    self.bigButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.smallButton.layer.masksToBounds = YES;
    self.smallButton.layer.cornerRadius = self.smallButton.frame.size.height/2;
    self.smallButton.layer.borderWidth = 0.5;
    self.smallButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.sumButton.layer.masksToBounds = YES;
    self.sumButton.layer.cornerRadius= 5;
    self.sumButton.backgroundColor = [UIColor orangeColor];
    self.sumButton.tintColor = [UIColor whiteColor];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.infoLabel.text = self.info;
    self.priceLabel.text = self.price;
    self.imageView.image = [UIImage imageNamed:self.image];
   // self.sumButton.textInputMode = self.price;
//    self.sumPrice =[[self.price stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue];
    self.price = [self.price stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.sumPrice = [self.price intValue];
    [self.sumButton setTitle:self.price forState:UIControlStateNormal];
    self.status = NO;
    self.smallButton.backgroundColor = [UIColor orangeColor];
    
    [self fetchDevices];
    
    self.object = 1;
   // self.sumLabel.text = self.object;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  //  self.view.frame = CGRectMake(0, 80, 100, 200);
}

#pragma mark - Method

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}

- (IBAction)smallButtonClick:(id)sender {
    self.status = NO;
    [self setColorbutton];
    
}

- (IBAction)bigButtonClick:(id)sender {
    self.status = YES;
    [self setColorbutton];
}

- (void)setColorbutton {
    if (self.status == YES) {
        self.smallButton.backgroundColor = [UIColor whiteColor];
        self.bigButton.backgroundColor = [UIColor orangeColor];
    }
    else{
        self.bigButton.backgroundColor = [UIColor whiteColor];
        self.smallButton.backgroundColor = [UIColor orangeColor];
    }
}

- (IBAction)addButtonClick:(id)sender {
    
    self.object ++ ;
    self.sumPrice = self.sumPrice + [self.price intValue];
    self.removeButton.enabled = YES;
    self.sumButton.enabled = YES;
    self.removeButton.backgroundColor = [UIColor orangeColor];
    self.sumLabel.text = [NSString stringWithFormat:@"%i",self.object];
    [self.sumButton setTitle:[NSString stringWithFormat:@"%i",self.sumPrice] forState:UIControlStateNormal];
}

- (IBAction)removeButtonClick:(id)sender {
    self.object --;
    self.sumPrice = self.sumPrice - [self.price intValue];
    if (self.object <= 0 && self.sumPrice <=0) {
        self.object = 0;
        self.sumPrice = 0;
        self.removeButton.enabled = NO;
        self.sumButton.enabled = NO;
        self.removeButton.backgroundColor = [UIColor grayColor];
    }
    self.sumLabel.text = [NSString stringWithFormat:@"%i",self.object];
    [self.sumButton setTitle:[NSString stringWithFormat:@"%i",self.sumPrice] forState:UIControlStateNormal];
}
- (void)fetchDevices  {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];

    NSMutableArray *arrayNew ;
    arrayNew = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"SL %lu",(unsigned long)arrayNew.count);
}

- (IBAction)submitButtonClick:(id)sender {
  //  Shopping *shoppingObject = [[Shopping alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newData;
    
        newData = [NSEntityDescription insertNewObjectForEntityForName:@"Shopping" inManagedObjectContext:context];
        [newData setValue:self.image forKey:@"image"];
        [newData setValue:self.info forKey:@"fullname"];
        [newData setValue:[NSString stringWithFormat:@"%d",self.sumPrice] forKey:@"sumprice"];
        [newData setValue:[NSString stringWithFormat:@"%d",self.object] forKey:@"soluong"];
        [newData setValue:[NSNumber numberWithInteger:self.idFood] forKey:@"idsanpham"];
        [newData setValue:self.price forKey:@"price"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else {
        NSLog(@"Data saved successfully ..");
        UIAlertController *shoppingAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Bạn đã đặt hàng thành công !" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
           [self dismissViewControllerAnimated:NO completion:nil];
        }];
        [shoppingAlert addAction:actionOK];
        [self presentViewController:shoppingAlert animated:NO completion:nil];
        
    }
    
}
@end
