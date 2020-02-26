# Qt和CMake开发Android应用程序
## Ubuntu 18.04
### 准备开发环境
  * 安装android studio
    ```
    sudo apt install cmake
    #从https://developer.android.com/studio/#downloads获取下载url
    wget https://dl.google.com/dl/android/studio/ide-zips/3.6.0.21/android-studio-ide-192.6200805-linux.tar.gz
    tar xzvf android-studio-ide-192.6200805-linux.tar.gz
    ```
    完成安装后, 运行studio.sh在GUI界面的SDK Manager中下载sdk tools, NDK等工具包
  * 安装qt
    ```
    wget https://download.qt.io/archive/qt/5.12/5.12.7/qt-opensource-linux-x64-5.12.7.run
    chmod a+x qt-opensource-linux-x64-5.12.7.run
    ./qt-opensource-linux-x64-5.12.7.run
    ```
    安装过程中选择所需要的android版本的Qt开发库，如果需要开发本地运行的程序, 同时选择安装本地版本的Qt开发库

### 编译Android APK
  * 设置环境变量
    ```
    export Qt_Android=<path to qt android>
    export Qt_Android_Deploy_Qt=$Qt_Android/bin/androiddeployqt
    export JAVA_HOME=<Android Studio安装目录>/jre
    export ANDROID_SDK=<path to android sdk directory>

    ANDROID_CMAKE_TOOLCHAIN=<path to ANDROID_NDK android.toolchain.cmake>
    ```
    其中`android.toolchain.cmake`文件在`ANDROID_NDK/build/cmake`目录, 安装Studio的过程中会将JDK安装到"<Android Studio安装目录>/jre", JAVA_HOME指向该目录即可

  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ../qt-android-cmake-tutorial -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CMAKE_TOOCHAIN -DANDROID_PLATFORM=android-24
    make apk
    ```
  其中`ANDROID_PLATFORM`中api的版本需要`>=24`

### 编译x86_64的HOST版本
  * 安装c/c++本地编译环境
    ```
    sudo apt install build-essential
    sudo apt install mesa-common-dev libglu1-mesa-dev
    ```
    在安装Qt时, 需要选择安装Qt开发库的本地版本
  * 设置环境变量`Qt_Host=<path to qt gcc_64>`
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ../qt-android-cmake-tutorial
    make
    ```

## Windows
### 准备开发环境
  * 安装android studio  
    从<https://developer.android.com/studio>下载安装包，完成安装后运行studio, 在GUI界面的SDK Manager中下载sdk tools, ndk等工具
  * 安装qt  
    从<https://download.qt.io/archive/qt/5.12/5.12.7/qt-opensource-windows-x86-5.12.7.exe>下载Qt5.12的安装包, 安装过程中选择所需的android版本的Qt开发库, 如果需要编译本地运行版本, 可以选择安装MinGW版本的Qt开发库以及相应的MinGW C/C++工具链

### 编译Android APK
  * 设置环境变量
    ```
    set Qt_Android=<path to qt android>
    set Qt_Android_Deploy_Qt=%Qt_Android%\bin\androiddeployqt.exe

    set JAVA_HOME=<Android Studio安装目录>\jre
    set ANDROID_SDK=<path to android sdk directory>
    set ANDROID_CMAKE_TOOLCHAIN=<path to ANDROID_NDK android.toolchain.cmake>
    set ANDROID_MAKE_PROGRAM=<path to ANDROID_NDK make.exe>
    ```
    其中`android.toolchain.cmake`文件在`ANDROID_NDK\build\cmake`目录; 安装Studio的过程中会将JDK安装到"<Android Studio安装目录>\jre", JAVA_HOME指向该目录即可
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ..\qt-android-cmake-tutorial -G"Unix Makefiles" -DCMAKE_MAKE_PROGRAM=%ANDROID_MAKE_PROGRAM% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_CMAKE_TOOLCHAIN% -DANDROID_PLATFORM=android-24
    cmake --build . --target apk
    ```
  其中`ANDROID_PLATFORM`中api的版本需要`>=24`

### 编译MinGW x86_64的HOST版本
  * 编译环境
    安装Qt的过程中，选择安装MinGW版本的Qt开发库, 以及相对应的MinGW C/C++工具链
  * 设置环境变量
    ```
    set Qt_Host=<path to mingw qt library>
    set PATH=<path to mingw c/c++ toolchain directory>;%PATH%
	```
  * 编译
    ```
    git clone https://github.com/luozhengjun/qt-android-cmake-tutorial.git
    mkdir build_qt-android-cmake-tutorial
    cd build_qt-android-cmake-tutorial
    cmake ..\qt-android-cmake-tutorial -G"MinGW Makefiles"
    cmake --build .
    ```
