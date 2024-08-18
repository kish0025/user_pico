# Minimum CMake version required
cmake_minimum_required(VERSION 3.13)

# Set the project name
project(PotentiometerProject)

# Set the path to the Pico SDK if not set externally
if (NOT DEFINED PICO_SDK_PATH)
    set(PICO_SDK_PATH "D:/000STM32/Potentiometer/Pico/pico-sdk-blink-main")
endif()

# Ensure that the path uses forward slashes or double backslashes
set(PICO_SDK_PATH ${PICO_SDK_PATH})

# Import the Pico SDK
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

# Initialize the SDK
pico_sdk_init()

# Define the executable
add_executable(potentiometer
    main.c
)

# Link the Pico SDK libraries
target_link_libraries(potentiometer pico_stdlib)

# Enable additional outputs (UF2, bin, hex, etc.)
pico_add_extra_outputs(potentiometer)
