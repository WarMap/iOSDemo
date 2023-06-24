//
//  BeeMediaMarco.h
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/4/26.
//  Copyright © 2023 Alipay. All rights reserved.
//

#ifndef BeeMediaMarco_h
#define BeeMediaMarco_h

#define adapt375(m) [UIScreen mainScreen].bounds.size.width/375.0*m

#define panelBGColor RGB(0x111111)
#define aliPayColor RGB(0x3086ff)


#if DEBUG

#define fjMT(model) model.texts.firstObject.content

#define fjlog(args...) \
NSLog(@"fengjiu %@",[NSString stringWithFormat:args]);

#else

#define fjlog(args...)
#define fjMT(model)

#endif

#endif /* BeeMediaMarco_h */
