
LANGUAGE=objective-c
TAREGT=x86_64-apple-macos11.3
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

FILE_NAME=test
LIBRARY_NAME=TestExample
HEAD_PATH=./dylib
LIBRARY_PATH=./dylib



echo "编译${FILE_NAME}.m --- ${FILE_NAME}.o"
clang -target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-I${HEAD_PATH} \
-c ${FILE_NAME}.m -o ${FILE_NAME}.o

pushd ${LIBRARY_PATH}
echo "编译${LIBRARY_NAME}.m --- ${LIBRARY_NAME}.o"
clang -target ${TAREGT} \
-fobjc-arc \
-isysroot ${SYSROOT} \
-c ${LIBRARY_NAME}.m -o ${LIBRARY_NAME}.o

echo "编译${LIBRARY_NAME}.o --- lib${LIBRARY_NAME}.a"

# Xcode->静态库
libtool -static -arch_only x86_64 ${LIBRARY_NAME}.o -o lib${LIBRARY_NAME}.a


echo "编译${LIBRARY_NAME}.m --- lib${LIBRARY_NAME}.dylib"
# -dynamiclib: 动态库
# dylib 最终链接产物 -》比静态库多走一次链接过程
ld -dylib -arch x86_64 \
-macosx_version_min 11.3 \
-syslibroot ${SYSROOT} \
-lsystem -framework Foundation \
-all_load \
lib${LIBRARY_NAME}.a -o lib${LIBRARY_NAME}.dylib

popd

echo "链接lib${LIBRARY_NAME}.dylib -- ${FILE_NAME} EXEC"
clang -target ${TAREGT} \
-fobjc-arc           \
-isysroot ${SYSROOT} \
-L${HEAD_PATH}       \
-l${LIBRARY_NAME}    \
${FILE_NAME}.o -o ${FILE_NAME}
