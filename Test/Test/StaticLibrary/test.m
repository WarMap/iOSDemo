#import "TestExample.h"
#import "Star.h"

int main(){
    TestExample *manager = [TestExample new];
    [manager output:nil];
    Star *star = [Star new];
    [star shining];
    return 0;
}




