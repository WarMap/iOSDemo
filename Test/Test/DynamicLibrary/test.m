#import <Foundation/Foundation.h>
//#import "TestExample.h"
//#import "Star.h"
#import "Moon.h"
#import "Sun.h"

int main(){
    NSLog(@"testApp----");
//    TestExample *manager = [TestExample new];
//    [manager lg_test: nil];
    Moon *star = [Moon new];
    [star shining];
    Sun *sun = [Sun new];
    [sun shining];
    return 0;
}




