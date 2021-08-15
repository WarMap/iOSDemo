#!/bin/sh

#  Moon.sh
#  Test
#
#  Created by 马鹏 on 2021/8/15.
#  
LANGUAGE=objective-c
TAREGT=x86_64-apple-macos11.3
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

LIBRARY=Moon
FRAMEWORK_NAME=Sun
HEAD_PATH=./Headers

echo "---------------------------------${LIBRARY}------------------------------------------------"

clang -target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-I${HEAD_PATH} \
-I./Frameworks/Sun.framework/${HEAD_PATH} \
-c ${LIBRARY}.m -o ${LIBRARY}.o

pushd ./Frameworks/${FRAMEWORK_NAME}.framework
rm ${FRAMEWORK_NAME}.o
rm ${FRAMEWORK_NAME}
sh ${FRAMEWORK_NAME}.sh
popd


clang -dynamiclib  \
-target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-F./Frameworks \
-framework ${FRAMEWORK_NAME} \
-Xlinker -install_name -Xlinker @rpath/${LIBRARY}.framework/${LIBRARY} \
${LIBRARY}.o -o ${LIBRARY}

install_name_tool -add_rpath @loader_path/Frameworks ${LIBRARY}
