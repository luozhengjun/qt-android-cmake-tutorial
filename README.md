# Qt和CMake开发Android应用程序
## ubuntu18.04
### 准备开发环境
  * 安装android studio
    ```
    sudo apt install cmake
    sudo apt install openjdk-8-jdk
    #从 https://developer.android.com/studio/#downloads 获取下载url
    wget https://dl.google.com/dl/android/studio/ide-zips/3.5.3.0/android-studio-ide-191.6010548-linux.tar.gz
    tar xzvf android-studio-ide-191.6010548-linux.tar.gz
    ```
    安装好studio之后, 运行studio.sh在GUI界面中下载sdk tools, 然后修改.profile或.bashrc文件将`android-studio/bin`,`Android/Sdk/tools/bin`,`Android/Sdk/platform-tools`目录添加到PATH
  * 安装android ndk bundle
    ```
    sdkmanager "ndk-bundle"
    ```
  * 安装qt for android
    ```
    wget https://download.qt.io/archive/qt/5.12/5.12.7/qt-opensource-linux-x64-5.12.7.run
    chmod a+x qt-opensource-linux-x64-5.12.7.run
    ./qt-opensource-linux-x64-5.12.7.run
    ```
    安装过程中选择所需要的android工具链

### 编译Android APK
  * 设置环境变量
    ```
    export Qt_Android=<path to qt android>
    export Qt_Android_Deploy_Qt=$Qt_Android/bin/androiddeployqt
    export JAVA_HOME=<path to java install directory>
	export ANDROID_SDK=<path to android sdk directory>

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

### 编译x86_64的HOST版本
  * 安装c/c++本地编译环境
    ```
    sudo apt install build-essential
    sudo apt install mesa-common-dev libglu1-mesa-dev
    ```
  * 设置环境变量`Qt_Host=<path to qt gcc_64>`
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ../android-cmake-tutorial
    make
    ```

