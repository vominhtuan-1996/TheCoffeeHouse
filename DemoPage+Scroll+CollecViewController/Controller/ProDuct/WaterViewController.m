//
//  WaterViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "WaterViewController.h"
#import "CollectionViewCell.h"
#import "PageViewController.h"
#import "PresentViewController.h"
#import "AppDelegate.h"

@interface WaterViewController () <CollectionViewCellDelegate,UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) NSMutableArray *arrayImage;
@property (strong, nonatomic) NSMutableArray *arrayInfo;
@property (strong, nonatomic) NSMutableArray *arrayPrice;
@property (weak, nonatomic) UIPopoverPresentationController *popup;
@property (strong, nonatomic) NSMutableArray *arrayNew;
@property (strong, nonatomic) Food *object;
@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(120, 220);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView setBounces:YES];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCell"];
//    static dispatch_once_t once;
//    dispatch_once(&once, ^ {
//        [self setData];
//    });
    [self fetchDevices];
    
    [self checkCoreData];
}

#pragma mark - Method

- (NSUInteger)checkCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@",@"Water"];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if (!error) {
        return count;
    } else {
        return NO;
    }
}

- (void)fetchDevices  {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@",@"Water"];
        [fetchRequest setPredicate:predicate];
  
    if ([self checkCoreData] == 0) {
        [self setData];
        self.arrayNew = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        [self.collectionView reloadData];
    } else {
        self.arrayNew = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        [self.collectionView reloadData];
    }
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayNew.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cells = @"CollectionViewCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cells forIndexPath:indexPath];
    cell.delegate = self;
    cell.index = indexPath.row;
    [cell setDataWithObject:self.arrayNew[indexPath.row] type:@"Water"];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (self.collectionView.frame.size.width /2 - 15)  ;
    CGFloat height = 260 ;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

#pragma mark - CollectionViewDelegate

- (void)showViewpresent:(NSUInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PresentViewController *presentVC = (PresentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PresentViewController"];
    presentVC.modalPresentationStyle = UIModalPresentationPopover;
    presentVC.preferredContentSize = CGSizeMake(self.view.bounds.size.width - 60, self.view.bounds.size.height - 100);
    
    self.popup = [presentVC popoverPresentationController];
    self.popup.sourceView = self.view;
    self.popup.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2 , 1, 1);
    self.popup.delegate = self;
    self.popup.permittedArrowDirections = 0;
    self.popup.backgroundColor = [UIColor whiteColor];
    Food *newFood = self.arrayNew[index];
    presentVC.image = newFood.image;
    presentVC.info = newFood.fullname;
    presentVC.price = newFood.price;
    presentVC.idFood = newFood.idFood;
  
    [self presentViewController:presentVC animated:YES completion:nil];
     //presentVC.image = [UIImage imageNamed:self.arrayImage[index]];
   
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - Data

- (void)setData {
    self.arrayImage = [NSMutableArray arrayWithObjects:
                       @"coffeeTN.jpeg",
                       @"coffee.jpg",
                       @"coffeesach.jpg",
                       @"CoffeeDL.jpeg",
                       @"traonglong.jpg",
                       @"miketee.jpg",
                       @"cooctail.jpg",
                       @"Matcha.jpg",
                       @"coffeemike.jpg",
                       @"nuochoaqua.jpg",
                       @"TraDao.jpeg",
                       @"trachanh.jpg",
                       @"trathaomoc.jpg",
                       nil];
    self.arrayInfo = [NSMutableArray arrayWithObjects:
                      @"Cappuccino Coffee",
                      @"Americano Coffee",
                      @"Caramel Cappucccino",
                      @"Espresso Coffee",
                      @"trà ô long (Oolong Tea)",
                      @"Hồng trà Sữa (Black Milk Tea)",
                      @"Trà Hoa Cúc (Chamomile Tea)",
                      @"Matcha Blended",
                      @"Cookies Coffee Mint",
                      @"Trà chanh sả, mật ong (Lemongrass Tea)",
                      @"Trà Đào Hàn Quốc (Korea Peach Tea)",
                      @"Sinh tố Xoài (Smoothies Mango)",
                      @"Trà Tiểu Long Châu (Dragon Pearls Tea)",
                      nil];
    self.arrayPrice = [NSMutableArray arrayWithObjects:
                       @"45000",
                       @"52000",
                       @"49000",
                       @"40000",
                       @"39000",
                       @"43000",
                       @"32000",
                       @"29000",
                       @"30000",
                       @"49000",
                       @"55000",
                       @"60000",
                       @"41000",
                       nil];
//    
   // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newData;

    for (int i = 0; i < self.arrayImage.count; i++){
        newData = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
        [newData setValue:self.arrayImage[i] forKey:@"image"];
        [newData setValue:self.arrayInfo[i] forKey:@"fullname"];
        [newData setValue:self.arrayPrice[i] forKey:@"price"];
        [newData setValue:@"Water" forKey:@"type"];
        [newData setValue:[NSNumber numberWithInteger:i] forKey:@"idFood"];
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else {
        NSLog(@"Data saved successfully ..");
    }
}

@end
