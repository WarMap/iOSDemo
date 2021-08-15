#!/bin/sh

#  sun.sh
#  Test
#
#  Created by 马鹏 on 2021/8/15.
#  
LANGUAGE=objective-c
TAREGT=x86_64-apple-macos11.3
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

LIBRARY=Sun
HEAD_PATH=./Headers


echo "---------------------------------${LIBRARY}------------------------------------------------"

clang -target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-I${HEAD_PATH} \
-c ${LIBRARY}.m -o ${LIBRARY}.o

clang -dynamiclib  \
-target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-Xlinker -install_name -Xlinker @rpath/${LIBRARY}.framework/${LIBRARY} \
${LIBRARY}.o -o ${LIBRARY}

