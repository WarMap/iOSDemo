#!/bin/sh

#  Script.sh
#  Test
#
#  Created by 马鹏 on 2021/8/15.
#
LANGUAGE=objective-c
TAREGT=x86_64-apple-macos11.3
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

LIBRARY=Star
HEAD_PATH=./Headers


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


#echo "-------DYLIB---------"
#otool -l ${LIBRARY} | grep 'DYLIB' -A 5
#echo "-------ID---------"
#otool -l ${LIBRARY} | grep 'ID' -A 5
#echo "-------RPATH---------"
#otool -l TestExample | grep 'RPATH' -A 5
