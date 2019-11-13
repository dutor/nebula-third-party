set(name wangle)
set(source_dir ${CMAKE_CURRENT_BINARY_DIR}/${name}/source)
ExternalProject_Add(
    ${name}
    URL https://github.com/facebook/wangle/archive/v2018.08.20.00.tar.gz
    URL_HASH MD5=b20856081c1d21c1a033f9ca161398c5
    DOWNLOAD_NAME wangle-2018-08-20.tar.gz
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/${name}
    TMP_DIR ${BUILD_INFO_DIR}
    STAMP_DIR ${BUILD_INFO_DIR}
    DOWNLOAD_DIR ${DOWNLOAD_DIR}
    SOURCE_DIR ${source_dir}
    SOURCE_SUBDIR wangle
    CMAKE_ARGS
        ${common_cmake_args}
        -DBoost_NO_SYSTEM_PATHS=OFF
        -DBUILD_TESTS=OFF
        -DCMAKE_EXE_LINKER_FLAGS=-latomic
        -DCMAKE_SHARED_LINKER_FLAGS=-latomic
        -D_OPENSSL_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib64
    BUILD_COMMAND make -s -j${BUILDING_JOBS_NUM}
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make -s -j${BUILDING_JOBS_NUM} install
    LOG_CONFIGURE TRUE
    LOG_BUILD TRUE
    LOG_INSTALL TRUE
    LOG_MERGED_STDOUTERR TRUE
)

ExternalProject_Add_Step(${name} clean
    EXCLUDE_FROM_MAIN TRUE
    DEPENDEES configure
    COMMAND make clean -j
    COMMAND rm -f ${BUILD_INFO_DIR}/${name}-build
    WORKING_DIRECTORY ${source_dir}/wangle
)

ExternalProject_Add_StepTargets(${name} clean)