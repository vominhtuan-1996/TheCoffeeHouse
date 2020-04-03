//
//  ShopViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/4/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ShopViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "ShopTableViewCell.h"
#import "AddressCollectionViewCell.h"
#import "AppDelegate.h"

@interface ShopViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate ,UIGestureRecognizerDelegate,ShopTableViewCellDelegate,AddressCollectionViewCellDelagate>
@property CLLocationManager *locationManager;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) BOOL isShowtableView;
@property (strong, nonatomic) NSMutableArray *addressArray;
@property (strong, nonatomic) NSMutableArray *arrayImage;
@property (strong, nonatomic) NSMutableArray *dictritArray;
@property (assign, nonatomic) BOOL isShowHeader;
@property (strong, nonatomic) NSMutableArray *arrayNew;
@property (strong, nonatomic) NSMutableArray *arraylatitube;
@property (strong, nonatomic) NSMutableArray *arraylongtitube;
@property (strong, nonatomic) NSMutableArray *arraytitle;
@property (strong, nonatomic) LocationGPS * objectLocation;
@property (assign, nonatomic) int zoom;
@end

@implementation ShopViewController

#pragma Mark - ViewCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Cửa hàng ";
    self.showHeadder.layer.cornerRadius = 8;
    self.showHeadder.userInteractionEnabled = YES;
    self.isShowHeader = NO;
    self.zoom = 20;
    self.viewTableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
     [self flowLayoutCollectionView];
     [self addAction];
     [self googleMaps];
     [self uinibCell];
   
    [self checkCoreData];
    [self fetchDevices];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  // [ self fetchDevices];
}

#pragma mark - Method

- (void)addAction {
    UITapGestureRecognizer *clickViewHeader = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(openOrhideFooter)];
    [self.showHeadder addGestureRecognizer:clickViewHeader];
}

- (void)flowLayoutCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(140, 160);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
}

- (void)uinibCell {
    
    UINib *nib = [UINib nibWithNibName:@"AddressCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"AddressCollectionViewCell"];
    
    nib = [UINib nibWithNibName:@"ShopTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ShopTableViewCell"];
}

- (NSUInteger)checkCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LocationGPS"];
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if (!error) {
        return count;
    } else {
        return NO;
    }
}

- (void)fetchDevices {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LocationGPS"];
    if ([self checkCoreData] == 0) {
        [self dataProject];
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

- (void) openOrhideFooter {
   if (self.isShowHeader == NO) {
        [UIView animateWithDuration:2 animations:^{
            [self openHiddenHeader:self.isShowHeader];
            self.isShowHeader = YES;
        }];
   } else {
       [UIView animateWithDuration:2 animations:^{
           [self openHiddenHeader:self.isShowHeader];
           self.isShowHeader = NO;
       }];
   }
}

- (void)openHiddenHeader:(BOOL) isShowHeader{
    if (self.isShowHeader == YES) {
        self.viewTableView.hidden = YES;
        self.viewColletionView.hidden = NO;
        self.mapView.settings.myLocationButton = YES;
        self.iconImageView.image = [UIImage imageNamed:@"downicon.jpeg"];
    } else {
        self.viewTableView.hidden = NO;
        self.viewColletionView.hidden = YES;
        self.mapView.settings.myLocationButton = NO;
        self.iconImageView.image = [UIImage imageNamed:@"upicon.png"];
    }
}

- (void)GPSindexactionlatitube:(CLLocationDegrees)latitube longitube:(CLLocationDegrees)longitube zoom:(float)zoom {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitube longitude:longitube zoom:zoom];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayNew.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cells = @"AddressCollectionViewCell";
    AddressCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cells forIndexPath:indexPath];
//    [cell setDataWithImage:[UIImage imageNamed:self.arrayImage[indexPath.row]] dictrict:self.addressArray[indexPath.row] address:self.stressArray[indexPath.row]];
    [cell setDataWithObject:self.arrayNew[indexPath.row]];
    cell.delegate = self;
    cell.index = (int)indexPath.row;
    return cell;
}

#pragma mark - CollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 140  ;
    CGFloat height = 160 ;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayNew.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCell = @"ShopTableViewCell";
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (cell == nil) {
        cell = [[ShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
    }
    
    //2.3 dang ky nhan uy thac
    //cell.delegate = self;
    //-------------------
    cell.delegate = self;;
    cell.index = (int)indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell setDataWithAddress:self.addressArray[indexPath.row]];
    [cell setdataWithObject:self.arrayNew[indexPath.row]];
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = UIColorFromHEX(0xf1f0f0);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 20, 40)];
    label.text = @"Thành phố Hồ Chí Minh";
    label.font = [UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    return view;
}

#pragma mark - ShopTableViewCellDelegate

- (void)hiddenCell:(int )index {
    [UIView animateWithDuration:1 animations:^{
        self.viewTableView.hidden = YES;
        self.viewColletionView.hidden = NO;
        self.mapView.settings.myLocationButton = YES;
        self.iconImageView.image = [UIImage imageNamed:@"downicon.jpeg"];
    }];
    LocationGPS *locationObject = self.arrayNew[index];
    self.latitude =[locationObject.latitube doubleValue];
    self.longitude =[locationObject.longtitube doubleValue];
    
    switch (index) {
        case 0:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 1:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 2:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 3:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 4:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 5:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 6:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 7:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 8:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 9:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 10:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        default:
            break;
    }
}

#pragma mark - AddressCollectionViewDelegate

- (void)selectAddress:(int)index {
    LocationGPS *locationObject = self.arrayNew[index];
    self.latitude =[locationObject.latitube doubleValue];
    self.longitude =[locationObject.longtitube doubleValue];
    switch (index) {
        case 0:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 1:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 2:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 3:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 4:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 5:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 6:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 7:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 8:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 9:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        case 10:
            [self GPSindexactionlatitube:self.latitude longitube:self.longitude zoom:self.zoom];
            break;
        default:
            break;
    }
    
}

#pragma mark - GMSMapViewDelegate

-(BOOL) didTapMyLocationButtonForMapView: (GMSMapView *) mapView {
   
   [ UIView animateWithDuration:10 animations:^{
       GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:18];
       self.mapView.camera = camera;
       self.mapView.myLocationEnabled = YES;
       self.mapView.settings.myLocationButton = YES;
       self.mapView.padding = UIEdgeInsetsMake(0, 0, 180, 15);
   }];
    return  YES;
}

- (void)googleMaps {
    
    NSString *string = @"AIzaSyDSWAS1Gfk27XkLD43r3S38Q67eHOzkPD4";
    [GMSPlacesClient provideAPIKey:string];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.mapView.delegate = self;
   // self.mapView.mapType = kGMSTypeNone;
    self.mapView.padding = UIEdgeInsetsMake(0, 0, 180, 15);
    [self.locationManager startUpdatingLocation];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    [self.locationManager requestAlwaysAuthorization];

    [self GPSindexactionlatitube:self.locationManager.location.coordinate.latitude longitube:self.locationManager.location.coordinate.longitude zoom:18];
    
 
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude );
    marker.tracksViewChanges = YES;
    marker.map = self.mapView;
    
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(10.783700, 106.694515);
    marker1.title = @"The Coffee House Signature";
    marker1.map = self.mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(10.789290, 106.779173);
    marker2.title = @"The Coffee House Nguyen Duy Trinh";
    marker2.map = self.mapView;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(10.773043, 106.687184);
    marker3.title = @"The Coffee House - Võ Văn Tần";
    marker3.map = self.mapView;
    
    GMSMarker *marker4 = [[GMSMarker alloc] init];
    marker4.position = CLLocationCoordinate2DMake(10.758709, 106.700510);
    marker4.title = @"The Coffee House - Đường 41";
    marker4.map = self.mapView;
   // marker.icon = [UIImage imageNamed:@"GMSMarket.png"];
    
    GMSMarker *marker5 = [[GMSMarker alloc] init];
    marker5.position = CLLocationCoordinate2DMake(10.771855, 106.657648);
    marker5.title = @"The Coffee House - Lý Thường Kiệt";
    marker5.map = self.mapView;
    
    GMSMarker *marker6 = [[GMSMarker alloc] init];
    marker6.position = CLLocationCoordinate2DMake(10.749833, 106.643584);
    marker6.title = @"The Coffee House - Hậu Giang";
    marker6.map = self.mapView;
    
    GMSMarker *marker7 = [[GMSMarker alloc] init];
    marker7.position = CLLocationCoordinate2DMake(10.738304, 106.715194);
    marker7.title = @"The Coffee House - Nguyễn Thị Thập";
    marker7.map = self.mapView;
    
    GMSMarker *marker8 = [[GMSMarker alloc] init];
    marker8.position = CLLocationCoordinate2DMake(10.735542, 106.689347);
    marker8.title = @"The Coffee House Trung Son";
    marker8.map = self.mapView;
    
    GMSMarker *marker9 = [[GMSMarker alloc] init];
    marker9.position = CLLocationCoordinate2DMake(10.820914, 106.772430);
    marker9.title = @"The Coffee House - Đỗ Xuân Hợp";
    marker9.map = self.mapView;
    
    GMSMarker *marker10 = [[GMSMarker alloc] init];
    marker10.position = CLLocationCoordinate2DMake(10.774075, 106.668514);
    marker10.title = @"The Coffee House Factory ";
    marker10.map = self.mapView;
    
    GMSMarker *marker11 = [[GMSMarker alloc] init];
    marker11.position = CLLocationCoordinate2DMake(10.850444, 106.760550);
    marker11.title = @"The Coffee House - Võ Văn Ngân";
    marker11.map = self.mapView;
}

#pragma mark -Data

- (void)dataProject {
   
    self.arraylongtitube = [NSMutableArray arrayWithObjects:
                            @"106.694515",
                            @"106.779173",
                            @"106.687184",
                            @"106.700510",
                            @"106.657648",
                            @"106.643584",
                            @"106.715194",
                            @"106.689347",
                            @"106.772430",
                            @"106.668514",
                            @"106.760550",
                            nil];
    
    self.arraylatitube = [NSMutableArray arrayWithObjects:
                          @"10.783700",
                          @"10.789290",
                          @"10.773043",
                          @"10.758709",
                          @"10.771855",
                          @"10.749833",
                          @"10.738304",
                          @"10.735542",
                          @"10.820914",
                          @"10.774075",
                          @"10.850444",
                          nil];
    self.addressArray = [NSMutableArray arrayWithObjects:
                         @"Quận 1",
                         @"Quận 2",
                         @"Quận 3",
                         @"Quận 4",
                         @"Quận 5",
                         @"Quận 6",
                         @"Quận 7",
                         @"Quận 8",
                         @"Quận 9",
                         @"Quận 10",
                         @"Thủ Đức",
                         nil];
    self.arrayImage = [NSMutableArray arrayWithObjects:
                       @"quan1.jpg",
                       @"nguyenduytrinhQ2.jpg",
                       @"Quan3.png",
                       @"quan4.jpg",
                       @"Quan5.jpg",
                       @"Quan6.jpeg",
                       @"Quan7.jpg",
                       @"Quan8.jpeg",
                       @"quan9.jpg",
                       @"quan11.jpg",
                       @"ThuDuc.jpg",
                       nil];
    self.dictritArray = [NSMutableArray arrayWithObjects:
                        @"19B Phạm Ngọc Thạch, Bến Nghé, Quận 1",
                        @"670 Đường Nguyễn Duy Trinh, Bình Trưng Đông, Quận 2",
                        @"223 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh",
                        @"35 - 37 Số 41, Phường 6, Quận 4",
                        @"249 Lý Thường Kiệt, Phường 15, Quận 5",
                        @"178 Đường Hậu Giang, Phường 6, Quận 6",
                        @"313 Nguyễn Thị Thập, Tân Phú, Quận 7",
                        @"112-114 Đường số 9A, Bình Hưng,Quận 8 ",
                        @"359 Đỗ Xuân Hợp, Phước Long B, Quận 9",
                        @"798 Sư Vạn Hạnh, Phường 12, Quận 10",
                        @"114 Võ Văn Ngân, Bình Thọ, Thủ Đức",
                        nil];
    self.arraytitle = [NSMutableArray arrayWithObjects:
                       @"The Coffee House Signature",
                       @"The Coffee House - Nguyễn Duy Trinh",
                       @"The Coffee House - Võ Văn Tần",
                       @"The Coffee House - Đường 41",
                       @"The Coffee House - Lý Thường Kiệt",
                       @"The Coffee House - Hậu Giang",
                       @"The Coffee House - Nguyễn Thị Thập",
                       @"The Coffee House - Trung Sơn",
                       @"The Coffee House - Đỗ Xuân Hợp",
                       @"The Coffee House - Sư Vạn Hạnh",
                       @"The Coffee House - Võ Văn Ngân",
                       nil];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newData;
    
    for (int i = 0; i < self.arrayImage.count; i++){
        newData = [NSEntityDescription insertNewObjectForEntityForName:@"LocationGPS" inManagedObjectContext:context];
        [newData setValue:self.arrayImage[i] forKey:@"image"];
        [newData setValue:self.arraytitle[i] forKey:@"title"];
        [newData setValue:self.arraylatitube[i] forKey:@"latitube"];
        [newData setValue:self.arraylongtitube[i] forKey:@"longtitube"];
        [newData setValue:self.addressArray[i] forKey:@"address"];
        [newData setValue:self.dictritArray[i] forKey:@"dictrict"];
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
