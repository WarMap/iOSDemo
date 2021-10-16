//
//  ViewController.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "ViewController.h"
#import "LRU.h"
#import "List.h"
#import "Search.h"
#import "BinaryTree.h"
#import "TwoSum.h"
#import "RobRoom.h"
#import "RemoveNthFromEnd.h"
#import "SearchRange.h"
#import "TreeSum.h"
#import "MaxArea.h"
#import "Permute.h"
#import "Canjump.h"
#import "MaxProfit.h"
#import "DailyTem.h"
#import "ValidBST.h"
@interface ViewController ()

@property (nonatomic, strong) LRU *lru;
@property (nonatomic, strong) List *list;
@property (nonatomic, strong) Search *search;
@property (nonatomic, strong) BinaryTree *bTree;
@end

@implementation ViewController

- (void)viewDidLoad {
    NSArray *arr =
//    @[@[@1,@1,@1],@[@1,@2,@2],@[@1,@3,@2],@[@2,@1],@[@1,@4,@4],@[@2,@2]];
    @[@[@1,@1,@1],@[@1,@2,@2],@[@2,@1],@[@1,@3,@3],@[@2,@2],@[@1,@4,@4],@[@2,@1],@[@2,@3],@[@2,@4]];

//    self.lru = [[LRU alloc] initWithArray:arr count:2];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self touchesBegan:[NSSet set] withEvent:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.list = [[List alloc] initWithAray:@[@1, @2, @3]];
//    self.list = [[List alloc] initWithAray:@[@1, @2, @3]];
//    self.list = [[List alloc] initWithAray:@[]];
//    [self.list reverse];
//    self.list = [[List alloc] initWithAray:@[@1, @2, @3,@4,@5] circlePoint:1];
//    [self.list checkCircle];
//    self.search = [[Search alloc] init];
//    [self.search bianrySearch:3];
    
//    self.bTree = [[BinaryTree alloc] init];
    
//    [TwoSum run];
//    [RobRoom run];
//    [RemoveNthFromEnd run];
//    [SearchRange run];
//    [TreeSum run];
//    [MaxArea run];
//    [Permute run];
//    [Canjump run];
//    [MaxProfit run];
//    [DailyTem run];
//    [BinaryTree run];
    [ValidBST run];
}
@end
