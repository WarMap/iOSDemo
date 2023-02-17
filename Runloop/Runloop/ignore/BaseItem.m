//
//  BaseItem.m
//  Runloop
//
//  Created by 马鹏 on 2023/2/17.
//

#import "BaseItem.h"
#import "MPPerson.h"

@implementation BaseItem

typedef void (^mpblock)(void);
typedef void (^MJBlock) (void);

struct __Block_byref_age_0 {
    void *__isa;
    struct __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    struct __Block_byref_age_0 *age;
};

+ (void)test {
    NSLog(@"subclass implementa this");
    MPPerson *person = [[MPPerson alloc] init];
    person.age = 3;
    NSObject *obj = [NSObject alloc];
    int b =7;
    int *a = &b;
    __block int age = 10;
    mpblock my = ^(void) {
        NSLog(@"11 %d", age);
    };
    struct __main_block_impl_0 *blockImp = (__bridge struct __main_block_impl_0 *)my;
    struct __main_block_impl_0 *blockImp12 = (__bridge struct __main_block_impl_0 *)^(void){
        NSLog(@"%d",age);
    };
    NSLog(@"my %@", my);
    my();
    NSLog(@"tmp %@", ^(void){NSLog(@"");});
    NSLog(@"obj %@", obj);
}

@end
