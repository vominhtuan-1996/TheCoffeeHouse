//
//  AppDelegate.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 10/30/19.
//  Copyright © 2019 VoMinhTuanIOS. All rights reserved.
//
@class AppDelegate;
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (assign,nonatomic) BOOL isShowController;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSString *fullname;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *emailGoogle;
@property (strong, nonatomic) NSString *idToken;

- (void)saveContext;

@end

