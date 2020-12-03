# Special case for geant4 since it has so many libraries
#
# find_ups_geant4(  [minimum] )
#  minimum - optional minimum version 

# Avoid unnecessary repeat inclusion.
include_guard(DIRECTORY)

cmake_policy(PUSH)
cmake_minimum_required(VERSION 3.18.2 FATAL_ERROR)

include(FindUpsPackage)

set(_fug_liblist G4FR G4GMocren G4OpenGL G4RayTracer G4Tree G4VRML
    G4analysis G4digits_hits G4error_propagation G4event G4geometry
    G4gl2ps G4global G4graphics_reps G4intercoms G4interfaces
    G4materials G4modeling G4parmodels G4particles G4persistency
    G4physicslists G4processes G4readout G4run G4track G4tracking
    G4visHepRep G4visXXX G4vis_management G4zlib)

macro(find_ups_geant4)
  find_ups_product(geant4 ${ARGN})
  if (Geant4_FOUND AND NOT _FUP_INTERFACE)
    find_ups_product(xerces_c v3_0_0 REQUIRED)
    # Add include directory to include path if it exists.
    if (NOT _FUP_INCLUDED_Geant4)
      include_directories($ENV{G4INCLUDE})
      set(_FUP_INCLUDED_Geant4 TRUE)
    endif()
    # Library variables.
    set(G4_LIB_LIST ${XERCES_C})
    foreach (_fug IN LISTS _fug_liblist)
      string(TOUPPER ${_fug} _FUG)
      find_library(${_FUG} NAMES "${_fug}" PATHS ENV G4LIB NO_DEFAULT_PATH)
      list(APPEND G4_LIB_LIST "${${_FUG}}")
    endforeach()
  endif()
endmacro()

cmake_policy(POP)
