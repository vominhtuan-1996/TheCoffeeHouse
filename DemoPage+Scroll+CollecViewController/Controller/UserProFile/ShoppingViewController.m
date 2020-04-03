//
//  ShoppingViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/21/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingTableViewCell.h"
#import "AppDelegate.h"
#import "AccountViewController.h"
#import "Shopping+CoreDataProperties.h"
#import "ShoppingCart.h"

@interface ShoppingViewController ()
@property (strong ,nonatomic) NSMutableArray *arrayNew;
@property (strong, nonatomic) Shopping *objectShopping;
@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backItem.title = @"Back";
    [self uinibCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
   // [self fetchDevices];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDevices];
//
}

#pragma Method

- (void)uinibCell {
    
    UINib *nib = [UINib nibWithNibName:@"ShoppingTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ShoppingTableViewCell"];
    
}

- (NSUInteger)checkCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if (!error) {
        return count;
    } else {
        return NO;
    }
}

- (void)deleteCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];
    
    self.arrayNew = [NSMutableArray new];
    
    NSMutableArray *arrayTemp = [NSMutableArray new];
    NSArray *localArray = [context executeFetchRequest:fetchRequest error:nil];
    for (Shopping* obj in localArray) {
        ShoppingCart *cartObj = [obj convertToShoppingCart];
        [arrayTemp removeObject:cartObj];
    }
    
    for (int i = 0; i < arrayTemp.count; i++) {
        ShoppingCart *shopingObj = arrayTemp[i];
        if (shopingObj.isCounted == NO) {
            for (int j = i + 1; j < arrayTemp.count; j++) {
                ShoppingCart *tmpObj = arrayTemp[j];
                if (shopingObj.idsanpham == tmpObj.idsanpham) {
                    int soluongtam = [shopingObj.soluong intValue];
                    int soluongJ = [tmpObj.soluong intValue];
                    int sumprice = [shopingObj.sumprice intValue];
                    int sumpriceJ = [tmpObj.sumprice intValue];
                    shopingObj.soluong = [NSString stringWithFormat:@"%d",soluongtam + soluongJ];
                    shopingObj.sumprice = [ NSString stringWithFormat:@"%d",sumprice + sumpriceJ];
                    
                    tmpObj.isCounted = YES;
                }
            }
        }
    }
    for (ShoppingCart* obj in arrayTemp) {
        if (obj.isCounted == NO) {
            [self.arrayNew removeObject:obj];
        }
    }
    [self.tableView reloadData];
}


- (void)fetchDevices {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];
   
    self.arrayNew = [NSMutableArray new];
    
    NSMutableArray *arrayTemp = [NSMutableArray new];
    NSArray *localArray = [context executeFetchRequest:fetchRequest error:nil];
    for (Shopping* obj in localArray) {
        ShoppingCart *cartObj = [obj convertToShoppingCart];
        [arrayTemp addObject:cartObj];
    }
    
    for (int i = 0; i < arrayTemp.count; i++) {
        ShoppingCart *shopingObj = arrayTemp[i];
        if (shopingObj.isCounted == NO) {
            for (int j = i + 1; j < arrayTemp.count; j++) {
                ShoppingCart *tmpObj = arrayTemp[j];
                if (shopingObj.idsanpham == tmpObj.idsanpham) {
                    int soluongtam = [shopingObj.soluong intValue];
                    int soluongJ = [tmpObj.soluong intValue];
                    int sumprice = [shopingObj.sumprice intValue];
                    int sumpriceJ = [tmpObj.sumprice intValue];
                    shopingObj.soluong = [NSString stringWithFormat:@"%d",soluongtam + soluongJ];
                    shopingObj.sumprice = [ NSString stringWithFormat:@"%d",sumprice + sumpriceJ];
                    
                    tmpObj.isCounted = YES;
                }
            }
        }
    }
    for (ShoppingCart* obj in arrayTemp) {
        if (obj.isCounted == NO) {
            [self.arrayNew addObject:obj];
        }
    }
    [self.tableView reloadData];
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}
#pragma mark - ACtion

- (IBAction)cancelButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayNew.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCell = @"ShoppingTableViewCell";
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (cell == nil) {
        cell = [[ShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataWithObject:self.arrayNew[indexPath.row]];
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Shopping"];
      //  self.arrayNew = [NSMutableArray new];
        ShoppingCart *cartObj;
        NSArray *localArray = [context executeFetchRequest:fetchRequest error:nil];
        for (Shopping* obj in localArray) {
            cartObj = [obj convertToShoppingCart];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idsanpham == %d",cartObj.idsanpham];
        [fetchRequest setPredicate:predicate];
        NSError * error = nil;
        NSArray *items = [context executeFetchRequest:fetchRequest error:&error];

        for (NSManagedObject *managedObject in items)
        {
            [context deleteObject:managedObject];
        }
        if (![context save:&error])
        {
            NSLog(@"Error ! %@", error);
        }
        [self fetchDevices];
        [self.arrayNew removeObjectsInArray:items];
      //  [self deleteCoreData];
     
        [self.tableView reloadData];
       
        
    }
}

@end
