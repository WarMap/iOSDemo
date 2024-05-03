//
//  LRU.m
//  Algorithm
//
//  Created by 马鹏 on 2021/9/4.
//

#import "LRU.h"

@interface Item : NSObject

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) Item *next;
@property (nonatomic, strong) Item *pre;

@end

@implementation Item

+ (instancetype)itemWithValue:(NSNumber *)value
                          key:(NSString *)key
                         next:(Item *)next
                          pre:(Item *)pre {
    Item *item = [[Item alloc] init];
    item.value = value;
    item.key = key;
    item.next = next;
    item.pre = pre;
    return item;
}

- (void)output {
    Item *tem = self;
    int i = 1;
    while (tem) {
        NSLog(@"第%d节点 - %@",i, tem.value);
        tem = tem.next;
        ++i;
    }
}

+ (instancetype)itemWithValue:(NSNumber *)value
                          key:(NSString *)key 
{
    Item *item = [[Item alloc] init];
    item.value = value;
    item.key = key;
    item.next = nil;
    item.pre = nil;
    return item;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.value];
}

@end


@interface LRU ()

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, strong) Item *headItem;
@property (nonatomic, strong) Item *tailItem;

@end

@implementation LRU

+ (void)run {
    Item *i0 = [Item itemWithValue:@(0) key:@"0"];
    Item *i1 = [Item itemWithValue:@(1) key:@"1"];
    Item *i2 = [Item itemWithValue:@(2) key:@"2"];
    Item *i3 = [Item itemWithValue:@(3) key:@"3"];
    LRU *lru = [[LRU alloc] initWithCapacity:5];
    [lru insertItemAtHead:i0];
    [lru insertItemAtHead:i1];
    [lru insertItemAtHead:i2];
    [lru insertItemAtHead:i3];
    [lru objectForKey:@"2"];
     [lru.headItem output];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        self.dic = [NSMutableDictionary dictionaryWithCapacity:capacity];
        self.capacity = capacity;
        self.count = 0;
    }
    return self;
}

#pragma mark - lru操作

// 读
// 写 1.直接写 2.读后写
// 删 1.删某个 2.删尾部 3 删所有

- (Item *)objectForKey:(id)key
{
    if (!key) {
        return nil;
    }
    Item *item = [self.dic objectForKey:key];
    if (item) {
        [self bringItemToHead:item];
    }
    return item;
}

- (void)insertItemAtHead:(Item *)item
{
    self.dic[item.key] = item;
    if (_headItem) { 
        item.next = _headItem;
        _headItem.pre = item;
        _headItem = item;
    } else {
        _headItem = _tailItem = item;
    }
}

- (void)bringItemToHead:(Item *)item
{
    if (_headItem == item) {
        return;
    }
    if (_tailItem == item) {
        _tailItem = _tailItem.pre;
        _tailItem.next = nil;
    } else {
        item.next.pre = item.pre;
        item.pre.next = item.next;
    }
    item.next = _headItem;
    item.pre = nil;
    _headItem.pre = item;
    _headItem = item;
}

- (void)removeItem:(Item *)item
{
    [self.dic removeObjectForKey:item.key];
    if (item.next) {
        item.next.pre = item.pre;
    }
    if (item.pre) {
        item.pre.next = item.next;
    }
    if (_headItem == item) {
        _headItem = item.next;
    }
    if (_tailItem == item) {
        _tailItem = item.pre;
    }
}

- (Item *)removeTailItem
{
    if (!_tailItem) {
        return nil;
    }
    Item *tail = _tailItem;
    [self.dic removeObjectForKey:_tailItem.key];
    if (_headItem == _tailItem) {
        _headItem = _tailItem = nil;
    } else {
        _tailItem = _tailItem.pre;
        _tailItem.next = nil;
    }
    return tail;
}

- (void)removeAll
{
    _headItem = _tailItem = nil;
    self.dic = [NSMutableDictionary dictionary];
}

@end
