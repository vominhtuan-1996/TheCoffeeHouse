//
//  Define.h
//  DemoPage+Scroll+CollecViewController
//
//  Created by VoMinhTuanIOS on 5/9/20.
//  Copyright © 2020 VoMinhTuanIOS. All rights reserved.
//

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...)
#endif

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
