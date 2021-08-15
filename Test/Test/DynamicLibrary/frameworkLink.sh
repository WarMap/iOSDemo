#!/bin/sh

#  frameworkLink.sh
#  Test
#
#  Created by 马鹏 on 2021/8/15.
#  

LANGUAGE=objective-c
TARGET='x86_64-apple-macos11.3'
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX11.3.sdk

FILE_NAME=test
FRAMEWORK_NAME=Star


echo "clean produts"
rm ${FILE_NAME}.o
rm ${FILE_NAME}
pushd ./Frameworks/${FRAMEWORK_NAME}.framework
rm ${FRAMEWORK_NAME}.o
rm ${FRAMEWORK_NAME}
popd


echo "编译${FILE_NAME}.m --- ${FILE_NAME}.o"
clang -target ${TARGET} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-I./Frameworks/${FRAMEWORK_NAME}.framework/Headers \
-c ${FILE_NAME}.m -o ${FILE_NAME}.o

pushd ./Frameworks/Star.framework
./Script.sh
popd

echo "编译${FILE_NAME}.o --- ${FILE_NAME}"
clang -target ${TARGET} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-F./Frameworks \
-framework ${FRAMEWORK_NAME} \
${FILE_NAME}.o -o ${FILE_NAME}

install_name_tool -add_rpath @executable_path/Frameworks ${FILE_NAME}


#echo "-------DYLIB---------"
#otool -l test | grep 'DYLIB' -A 5
#echo "-------RPATH---------"
#otool -l test | grep 'RPATH' -A 5

