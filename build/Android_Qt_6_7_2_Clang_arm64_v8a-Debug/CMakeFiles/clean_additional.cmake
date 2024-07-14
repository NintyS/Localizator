# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appLocalizator_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appLocalizator_autogen.dir/ParseCache.txt"
  "appLocalizator_autogen"
  )
endif()
