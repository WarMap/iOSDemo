//
//  ViewController.m
//  DSYM
//
//  Created by 马鹏 on 2021/8/21.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <mach-o/dyld.h>

@interface ViewController ()

@end

uintptr_t get_silde_address(void) {
    uintptr_t vmaddress_slide = 0;
    //遍历所有镜像
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const char *image_name = (char *)_dyld_get_image_name(i);
        const struct mach_header *header = _dyld_get_image_header(i);
        if (header->filetype == MH_EXECUTE) {
            //拿到当前镜像的偏移
            vmaddress_slide = _dyld_get_image_vmaddr_slide(i);
        }
        NSString *str = [NSString stringWithUTF8String:image_name];
        
        if ([str containsString:@"DSYM"]) {
            //如果是app的镜像，就是我们要找的
            NSLog(@"image name %s at address 0x%llx and ASLR slide 0x%lx \n", image_name, (mach_vm_address_t)header, vmaddress_slide);
            break;
        }
    }
    return (uintptr_t)vmaddress_slide;
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self crash];
    [self getMethodVMA];
}

- (void)crash {
    [NSArray array][1];
}

//拿到真实地址
- (void)getMethodVMA {
    IMP imp = (IMP)class_getMethodImplementation(self.class, @selector(crash));
    unsigned long import = (unsigned long)imp;
    unsigned long slide = get_silde_address();
    
    unsigned long addr = import - slide;
    NSLog(@"addr = %l", addr);
}
/*
 ➜  Debug-iphoneos dwarfdump --lookup 0x0000000100005e10 DSYM.app.dSYM
 DSYM.app.dSYM/Contents/Resources/DWARF/DSYM:    file format Mach-O arm64
 0x0004982c: Compile Unit: length = 0x0000020a, format = DWARF32, version = 0x0004, abbr_offset = 0x0000, addr_size = 0x08 (next unit at 0x00049a3a)

 0x00049837: DW_TAG_compile_unit
               DW_AT_producer    ("Apple clang version 12.0.5 (clang-1205.0.22.9)")
               DW_AT_language    (DW_LANG_ObjC)
               DW_AT_name    ("/Users/mapeng/Documents/github/iOSDemo/DSYM/DSYM/ViewController.m")
               DW_AT_LLVM_sysroot    ("/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS14.5.sdk")
               DW_AT_APPLE_sdk    ("iPhoneOS14.5.sdk")
               DW_AT_stmt_list    (0x0000ac6a)
               DW_AT_comp_dir    ("/Users/mapeng/Documents/github/iOSDemo/DSYM")
               DW_AT_APPLE_major_runtime_vers    (0x02)
               DW_AT_low_pc    (0x0000000100005c9c)
               DW_AT_high_pc    (0x0000000100005ee4)

 0x00049954:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000100005e10)
                 DW_AT_high_pc    (0x0000000100005e74)
                 DW_AT_frame_base    (DW_OP_reg29 W29)
                 DW_AT_object_pointer    (0x0004996e)
                 DW_AT_name    ("-[ViewController crash]")
                 DW_AT_decl_file    ("/Users/mapeng/Documents/github/iOSDemo/DSYM/DSYM/ViewController.m")
                 DW_AT_decl_line    (46)
                 DW_AT_prototyped    (true)
 Line info: file 'ViewController.m', line 46, column 0, start line 46
 */

@end
