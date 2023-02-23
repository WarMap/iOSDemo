//
//  MPRWLock.m
//  Thread
//
//  Created by 马鹏 on 2023/2/21.
//

#import "MPRWLock.h"

@interface MPRWLock ()

@property (nonatomic, assign) dispatch_semaphore_t sem;

@end

@implementation MPRWLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sem = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)read {
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_NOW);
    // read

}

- (void)write {
    dispatch_semaphore_wait(<#dispatch_semaphore_t  _Nonnull dsema#>, <#dispatch_time_t timeout#>)
}

@end
