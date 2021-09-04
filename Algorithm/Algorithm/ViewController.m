//
//  ViewController.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "ViewController.h"
#import "LRU.h"
@interface ViewController ()

@property (nonatomic, strong) LRU *lru;
@end

@implementation ViewController

- (void)viewDidLoad {
    NSArray *arr =
//    @[@[@1,@1,@1],@[@1,@2,@2],@[@1,@3,@2],@[@2,@1],@[@1,@4,@4],@[@2,@2]];
    @[@[@1,@1,@1],@[@1,@2,@2],@[@2,@1],@[@1,@3,@3],@[@2,@2],@[@1,@4,@4],@[@2,@1],@[@2,@3],@[@2,@4]];

    self.lru = [[LRU alloc] initWithArray:arr count:2];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
