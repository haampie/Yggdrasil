using BinaryBuilder

name = "EDFlib"
version = v"1.16.0"

sources = [
    ArchiveSource("https://www.teuniz.net/edflib/edflib_116.tar.gz",
                  "cc9f9cc63869fa5742a7dd7e1aa3ff69fedcd4547f2c56ada43d4a4bfa4c6a4e")
]

script = raw"""
cd ${WORKSPACE}/srcdir/edflib*
${CC} edflib.c -shared -fPIC -o ${libdir}/libedflib.${dlext}
"""

platforms = supported_platforms()

products = [
    LibraryProduct("libedflib", :libedflib)
]

dependencies = [
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
