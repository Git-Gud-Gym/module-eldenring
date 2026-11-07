cmake_minimum_required(VERSION 3.20)
project(GitGudGymEldenRing LANGUAGES CXX RC)

# The SDK version this module is built against. To develop against a local SDK checkout:
#   build.bat -DFETCHCONTENT_SOURCE_DIR_GGG_SDK=..\sdk
include(FetchContent)
FetchContent_Declare(ggg_sdk
    GIT_REPOSITORY https://github.com/Git-Gud-Gym/sdk.git
    GIT_TAG v0.1.0
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(ggg_sdk)

ggg_add_module(
    ID eldenring
    MANIFEST module.json
    INI gitgudgym-eldenring.ini
    RC src/module.rc
    SOURCES
        src/dllmain.cpp
        src/eldenring_game.cpp
        src/offsets.cpp
)
target_include_directories(module_eldenring PRIVATE src)
