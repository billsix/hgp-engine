#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])
AC_INIT([hgp-engine],[0.0.1], [billsix@gmail.com])

# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 src/Makefile
		 src/config.scm
		 ])

#AC_SUBST(ac_unique_file)
#AC_CONFIG_SRCDIR(src/config.scm.in)
export LIBBUG_INCLUDE_DIR=$(pkg-config --variable=includedir libbug)
AC_SUBST(LIBBUG_INCLUDE_DIR)
export LIBBUG_LOADABLE_LIBS=$(pkg-config --variable=loadablelibs libbug)
AC_SUBST(LIBBUG_LOADABLE_LIBS)
export LIBBUG_LIB_DIR=$(pkg-config --variable=libdir libbug)
AC_SUBST(LIBBUG_LIB_DIR)



AC_OUTPUT

