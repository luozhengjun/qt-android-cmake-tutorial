cmake_minimum_required(VERSION 3.10)

if(NOT ANDROID)
    message(FATAL_ERROR "Should only be used in android development.")
endif()

function(set_qt_search_path)
    set(CMAKE_FIND_ROOT_PATH "")
    set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} "$ENV{Qt_Android}" PARENT_SCOPE)
endfunction()

get_filename_component(deploy_settings_json_in
    ${CMAKE_CURRENT_LIST_DIR}/deployment-settings.json.in ABSOLUTE
)

function(add_android_app target)
    set(list_args SOURCES LIBRARIES)
    cmake_parse_arguments(_args "" "" "${list_args}" ${ARGN})

    add_library(target SHARED ${_args_SOURCES})
    target_link_libraries(target ${_args_LIBRARIES})

    set(APP_DIR ${CMAKE_BINARY_DIR}/bin)
    set(APP_SO_NAME "lib${target}.so")
    set(APP_SO_DIR ${APP_DIR}/${CMAKE_ANDROID_ARCH_ABI})
    set(ANDROID_APP_SO ${APP_SO_DIR}/${APP_SO_NAME})

    set_target_properties(target
        PROPERTIES
        PREFIX ""
        SUFFIX ""
        LIBRARY_OUTPUT_NAME ${APP_SO_NAME}
        LIBRARY_OUTPUT_DIRECTORY ${APP_SO_DIR}
    )

    get_filename_component(Qt_Android "$ENV{Qt_Android}" ABSOLUTE)
    if(NOT JAVA_HOME)
        get_filename_component(JAVA_HOME "$ENV{JAVA_HOME}" ABSOLUTE)
    endif()
    if(NOT ANDROID_SDK)
        get_filename_component(ANDROID_SDK "$ENV{ANDROID_SDK}" ABSOLUTE)
    endif()

    get_filename_component(STDCPP_PATH
        ${CMAKE_ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/${CMAKE_ANDROID_ARCH_ABI}/libc++_shared.so ABSOLUTE)

    set(deploy_settings_json ${CMAKE_BINARY_DIR}/deployment-settings.json)
    configure_file(${deploy_settings_json_in} ${deploy_settings_json})

    set(android_build_dir ${CMAKE_BINARY_DIR}/android-build)
    set(android_deploy_qt "$ENV{Qt_Android_Deploy_Qt}")
    add_custom_command(
        OUTPUT build_apk
        DEPENDS target
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${APP_DIR} ${android_build_dir}/libs
	COMMAND ${android_deploy_qt} --output ${android_build_dir} --input ${deploy_settings_json} --android-platform ${ANDROID_PLATFORM} --jdk ${JAVA_HOME} --gradle
    )
    add_custom_target(apk DEPENDS build_apk)

endfunction()
