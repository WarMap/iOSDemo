//
//  UIDemoPch.h
//  UIDemo
//
//  Created by fengjiu on 2023/5/17.
//

#ifndef UIDemoPch_h
#define UIDemoPch_h
#import <UIKit/UIKit.h>
#import "UIView+kit.h"

#define WS(weakSelf) __weak typeof (self) weakSelf = self;

#define RGB(c) \
[UIColor colorWithRed:(((c) & 0xff0000) >> 16) / 255.0f \
green:(((c) & 0xff00) >> 8) / 255.0f \
blue:((c) & 0xff) / 255.0f \
alpha:1.0]

#define RGB_A(c,a) \
[UIColor colorWithRed:(((c) & 0xff0000) >> 16) / 255.0f \
green:(((c) & 0xff00) >> 8) / 255.0f \
blue:((c) & 0xff) / 255.0f \
alpha:a]

NS_INLINE UIImage * BME_IMG(NSString *name) {
    return [UIImage imageNamed:name];
}

#define BeeLogInfo(tag,fmt, ...) \
NSLog(@"===>>>Tag:" tag@", " fmt, ##__VA_ARGS__); 

#endif /* UIDemoPch_h */
