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
                          key:(NSString *)key {
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
    [lru addItem:i0];
    [lru addItem:i1];
    [lru addItem:i2];
    [lru addItem:i3];
    [lru getItemWithKey:@"2"];
     [lru.headItem output];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        self.dic = [NSMutableDictionary dictionaryWithCapacity:capacity];
        self.headItem = [Item itemWithValue:@(-1) key:@"head"];
        self.tailItem = [Item itemWithValue:@(-1) key:@"tail"];
        self.headItem.next = self.tailItem;
        self.tailItem.pre = self.headItem;
        self.capacity = capacity;
        self.count = 0;
    }
    return self;
}

#pragma mark - lru操作

- (Item *)getItemWithKey:(NSString *)key {
    if (key.length <= 0 && !self.dic[key]) {
        return nil;
    }
    Item *item = self.dic[key];
    [self move2Head:item];
    return item;
}

- (void)addItem:(Item *)item {
    if (!item) {
        return;
    }
    if (!self.dic[item.key]) {
        [self add2Head:item];
        self.dic[item.key] = item;
        self.count += 1;
        if (self.count > self.capacity) {
            Item *removed = [self removeTail];
            self.dic[removed.key] = nil;
            self.count -= 1;
        }
    } else {
        Item *tmp = self.dic[item.key];
        tmp.value = item.value;
        [self move2Head:tmp];
    }
}

- (void)add2Head:(Item *)item {
    item.pre = self.headItem;
    item.next = self.headItem.next;
    self.headItem.next.pre = item;
    self.headItem.next = item;
}

- (void)move2Head:(Item *)item {
    [self removeItem:item];
    [self add2Head:item];
}

- (void)removeItem:(Item *)item {
    item.pre.next = item.next;
    item.next.pre = item.pre;
}

- (Item *)removeTail {
    Item *item = self.tailItem.pre;
    [self removeItem:item];
    return item;
}

@end
