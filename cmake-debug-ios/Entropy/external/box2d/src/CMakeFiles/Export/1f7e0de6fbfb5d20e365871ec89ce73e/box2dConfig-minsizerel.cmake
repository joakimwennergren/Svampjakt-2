#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "box2d::box2d" for configuration "MinSizeRel"
set_property(TARGET box2d::box2d APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(box2d::box2d PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "C"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libbox2d.a"
  )

list(APPEND _cmake_import_check_targets box2d::box2d )
list(APPEND _cmake_import_check_files_for_box2d::box2d "${_IMPORT_PREFIX}/lib/libbox2d.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
