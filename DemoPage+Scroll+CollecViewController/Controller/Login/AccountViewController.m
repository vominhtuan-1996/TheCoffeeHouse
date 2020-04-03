//
//  AccountViewController.m
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 11/13/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//

#import "AccountViewController.h"
#import <FBSDKCoreKit/FBSDKProfile.h>
#import "AccountTableViewCell.h"
#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "AppDelegate.h"
#import "UserProFileViewController.h"
#import "ShoppingViewController.h"

@interface AccountViewController()<UIGestureRecognizerDelegate,AccountTableViewCellDelegate,UIApplicationDelegate>
@property (strong ,nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *idToken;
@property (strong, nonatomic) NSMutableArray *arrayNew;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tài Khoản";
    // Do any additional setup after loading the view.
    [self dataWithSignInFaceBook];
    [self DatasigninGoogle];
    [self.tableView reloadData];
    [self setData];
    [self initCell];
    self.avatarImageView.layer.cornerRadius = 35;
    self.avatarImageView.layer.borderColor = [UIColor purpleColor].CGColor;
    [self tapgesAvaterImageView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

#pragma mark - Method
- (NSUInteger)checkCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AccountGoogle"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idTokenr"];
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AccountGoogle"];
    self.arrayNew = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}

- (void)dataWithSignInFaceBook {
    dispatch_async(dispatch_get_main_queue(), ^{
        [FBSDKProfile loadCurrentProfileWithCompletion:^(FBSDKProfile *profile, NSError *error) {
            if (profile) {
                self.fullnameLabel.font = [UIFont systemFontOfSize:22];
                self.fullnameStr = [NSString stringWithFormat:@"%@ %@",profile.firstName,profile.lastName];
                self.fullnameLabel.text = self.fullnameStr;
                NSURL *urlstr = [profile imageURLForPictureMode:FBSDKProfilePictureModeSquare size:CGSizeMake(70, 70)];
                self.url = urlstr;
                self.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlstr]];
            }
        }];
    });
}

- (void)datawithSignInFaceBookUserProFile {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserProFileViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"UserProFileViewController"];
    controller.fullname =self.fullnameStr;
    controller.urlImage = self.url;
    
    //controller.birthday = profile.
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)DatasigninGoogle {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.fullnameLabel.font = [UIFont systemFontOfSize:22];
    self.fullnameLabel.text = delegate.fullname;
    self.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:delegate.imageURL]];
    self.email = delegate.emailGoogle;
    self.idToken = delegate.idToken;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newData;
        newData = [NSEntityDescription insertNewObjectForEntityForName:@"AccountGoogle" inManagedObjectContext:context];
        [newData setValue:delegate.fullname forKey:@"fullname"];
        [newData setValue:delegate.idToken forKey:@"idToken"];
        [newData setValue:delegate.emailGoogle forKey:@"email"];
        [newData setValue:[NSString stringWithFormat:@"%@",delegate.imageURL] forKey:@"image"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else {
        NSLog(@"Data saved successfully ..");
    }
    [self fetchDevices];
}

- (void)dataSigninGoogleProfile {
AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
UserProFileViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"UserProFileViewController"];
controller.fullname = delegate.fullname;
controller.urlImage = delegate.imageURL;
controller.birthday = delegate.emailGoogle;
[self presentViewController:controller animated:YES completion:nil];
}

- (void)initCell {
    UINib  *nib = [UINib nibWithNibName:@"AccountTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AccountTableViewCell"];
}

- (void)tapgesAvaterImageView {
    self.avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSomething:)];
    [self.avatarImageView addGestureRecognizer:gestureRecognizer];
}

- (void)doSomething:(UITapGestureRecognizer *) sender {

    NSLog(@"dadasd");
}

#pragma mark -TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCell = @"AccountTableViewCell";
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (cell == nil) {
        cell = [[AccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
    }
    cell.delegate = self;
    cell.index = (int)indexPath.row;
    [cell setDataWithImage:[UIImage imageNamed:self.imageArray[indexPath.row]] name:self.nameArray[indexPath.row]];
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - AccountAccountTableViewCell

- (void)tapgesAction:(int) index {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
     UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (index) {
        case 0:
            NSLog(@"dadhagfds");
            break;
        case 1:
            if ([FBSDKAccessToken currentAccessToken]) {
            [self datawithSignInFaceBookUserProFile];
            }
            [self dataSigninGoogleProfile];
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
        {
            ShoppingViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ShoppingViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 5:
            break;
        case 6:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Xác nhận" message:@"Bạn có chắt chắn muốn thoát không ? " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"Có" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                 [loginManager logOut];
                [[GIDSignIn sharedInstance] signOut];
                UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                controller.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:controller animated:YES completion:nil];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Không" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionOK];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Data

- (void)setData {
    self.imageArray = [NSMutableArray arrayWithObjects:
                       @"reward.png",
                       @"acccount.png",
                       @"music.png",
                       @"history.png",
                       @"cash.png",
                       @"setting.png",
                       @"logout.png",
                       nil];
    self.nameArray = [NSMutableArray arrayWithObjects:
                    @"The Coffee House Rewards",
                    @"Thông tin tài khoản",
                    @"Nhạc đang phát",
                    @"Lịch sử",
                    @"Thanh Toán",
                    @"Cài đặt",
                    @"Đăng xuất",
                    nil];
}

@end
