//
//  main.m
//  Test
//
//  Created by 马鹏 on 2021/8/11.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
void deadcode(void) {
    NSLog(@"deaddddddd");
}
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
