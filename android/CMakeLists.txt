get_filename_component(Qt5_android $ENV{Qt5_Android} ABSOLUTE)
if(NOT ANDROID_SDK)
    get_filename_component(ANDROID_SDK ${CMAKE_ANDROID_NDK}/.. ABSOLUTE)
endif()

get_filename_component(STDCPP_PATH
    ${CMAKE_ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/${CMAKE_ANDROID_ARCH_ABI}/libc++_shared.so ABSOLUTE)

set(deploy_settings_json ${CMAKE_BINARY_DIR}/deployment-settings.json)
configure_file(deployment-settings.json.in ${deploy_settings_json})

set(android_build_dir ${CMAKE_BINARY_DIR}/android-build)
set(android_deploy_qt $ENV{Qt5_Android_Deploy_Qt})
message("android_deploy_qt: ${android_deploy_qt}")
add_custom_command(
    OUTPUT create_apk
    DEPENDS ${ANDROID_APP_SO}
    COMMAND ${CMAKE_MAKE_PROGRAM} destdir=${android_build_dir} install
    COMMAND ${android_deploy_qt} --output ${android_build_dir} --input ${deploy_settings_json} --android-platform android-29 --jdk /usr/lib/jvm/java-8-openjdk-amd64 --gradle
)

add_custom_target(apk DEPENDS create_apk)

