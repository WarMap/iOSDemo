//
//  main.m
//  Runloop
//
//  Created by mapeng on 2021/5/29.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MPRunloopObserver.h"

int main(int argc, char * argv[]) {
    
//    [MPRunloopObserver beginObserver];
    
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
