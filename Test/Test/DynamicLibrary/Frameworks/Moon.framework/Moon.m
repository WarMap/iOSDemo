//
//  Moon.m
//  Test
//
//  Created by 马鹏 on 2021/8/15.
//

#import "Moon.h"
#import "Sun.h"
@implementation Moon

- (void)shining {
    Sun *sun = [Sun new];
    [sun shining];
    NSLog(@"moon is shining!");
}

@end
