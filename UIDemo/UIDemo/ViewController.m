//
//  ViewController.m
//  UIDemo
//
//  Created by fengjiu on 2023/5/16.
//

#import "ViewController.h"
#import "BMFloweryCharacterManager.h"


@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSHashTable *weakArray;
@property (nonatomic, strong) BMFloweryCharacterManager *manager;
@end

@implementation ViewController

#define textHeight  36
- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[BMFloweryCharacterManager alloc] init];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.manager showPanelWithContainer:self.view sibling:nil];
}


@end

