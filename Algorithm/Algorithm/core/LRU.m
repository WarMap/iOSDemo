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

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.value];
}

@end


@interface LRU ()

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) Item *firstItem;
@property (nonatomic, strong) Item *lastItem;

@end

@implementation LRU

- (instancetype)initWithArray:(NSArray *)array count:(NSUInteger)count {
    if (self = [super init]) {
        self.dic = [NSMutableDictionary dictionaryWithCapacity:count];
        self.count = count;
        [self parseArray:array];
    }
    return self;
}

- (void)parseArray:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSArray class]]) {
            return;
        }
        NSNumber *opt = obj.firstObject;
        if (opt.intValue == 1) {
            // write
            NSString *key = ((NSNumber *)obj[1]).stringValue;
            [self storeValve:obj.lastObject key:key];
        } else if (opt.intValue == 2) {
            //read
            NSString *key = ((NSNumber *)obj[1]).stringValue;
            NSLog(@"%@", [self readValueWithKey:key]) ;
        }
        
    }];
}

#pragma mark - lru操作

- (void)storeValve:(NSNumber *)value key:(NSString *)key {
    Item *tmp = [[Item alloc] init];
    tmp.value = value;
    tmp.key = key;
    [self setItem2First:tmp];
    if (!self.lastItem) {
        self.lastItem = tmp;
    }
    self.dic[key] = tmp;
    [self cut];
}

- (NSNumber *)readValueWithKey:(NSString *)key {
    Item *tmp = self.dic[key];
    if (tmp) {
        [self deleteItem:tmp];
        [self setItem2First:tmp];
        return tmp.value;
    }
    return @(-1);
}

- (void)cut {
    while (self.dic.allKeys.count > _count) {
        [self.dic allKeysForObject:self.lastItem];
        [self deleteItem:self.lastItem];
    }
}

#pragma mark - 链表操作
/// 添加到链表头
/// @param item <#item description#>
- (void)setItem2First:(Item *)item {
    if (!item || item.key.length == 0 || item == self.firstItem) {
        return;
    }
    self.dic[item.key] = item;
    item.next = self.firstItem;
    self.firstItem.pre = item;
    self.firstItem = item;
}


/// 删除链表某个节点
/// @param item <#item description#>
- (void)deleteItem:(Item *)item {
    if (self.lastItem == item) {
        self.lastItem = item.pre;
    }
    if (self.firstItem == item) {
        self.firstItem = item.next;
    }
    self.dic[item.key] = nil;
    item.pre.next = item.next;
    item.next = item.pre;
}






@end
