#!/bin/sh

#  build.sh
#  Test
#
#  Created by 马鹏 on 2021/8/14.
#  
LANGUAGE=objective-c
TAREGT=x86_64-apple-macos11.3
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

FILE_NAME=test
STATICLIBRARY=TestExample
LIBFIlESTAR=Star
HEAD_PATH=./Library
LIBRARY_PATH=./Library

echo "-------------编译test.m to test.o------------------"
clang -x $LANGUAGE  \
-target $TAREGT     \
-fobjc-arc          \
-isysroot $SYSROOT  \
-I${HEAD_PATH}   \
-c ${FILE_NAME}.m -o ${FILE_NAME}.o

echo "-------------进入到StaticLibrary目录------------------"
pushd ${HEAD_PATH}
echo "-------------编译TestExample.m to TestExample.o------------------"
clang -x $LANGUAGE  \
-target $TAREGT     \
-fobjc-arc          \
-isysroot $SYSROOT  \
-c ${STATICLIBRARY}.m -o ${STATICLIBRARY}.o

clang -x $LANGUAGE  \
-target $TAREGT     \
-fobjc-arc          \
-isysroot $SYSROOT  \
-c ${LIBFIlESTAR}.m -o ${LIBFIlESTAR}.o

ar -rc "lib${STATICLIBRARY}.a" ${STATICLIBRARY}.o
ar -rc "lib${STATICLIBRARY}.a" ${LIBFIlESTAR}.o

echo "-------------退出StaticLibrary目录------------------"

popd

echo "-------------test.o链接libTestExample.a to test EXEC------------------"
clang -target $TAREGT   \
-fobjc-arc              \
-isysroot $SYSROOT      \
-L${LIBRARY_PATH}       \
-l${STATICLIBRARY}           \
$FILE_NAME.o -o $FILE_NAME

