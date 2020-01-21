# Qt和CMake开发Android应用程序
## 准备开发环境

## 编译Android APK
  * 设置环境变量
    ```
    export Qt_Host=<path to qt gcc_64>
    export Qt_Android=<path to qt android>
    export Qt_Android_Deploy_Qt=$Qt5_Android/bin/androiddeployqt
    export JAVA_HOME=<path to java install directory>

    ANDROID_CMAKE_TOOLCHAIN=<path to ANDROID_NDK android.toolchain.cmake>
    ```
    其中`android.toolchain.cmake`文件在`ANDROID_NDK/build/cmake`目录
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ../android-cmake-tutorial -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CMAKE_TOOCHAIN -DANDROID_PLATFORM=android-24
    make apk
    ```
  其中`ANDROID_PLATFORM`中api的版本需要`>=24`

## 编译x86_64的HOST版本
  * 设置环境变量`Qt_Host=<path to qt gcc_64>`
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ../android-cmake-tutorial
    make
    ```

