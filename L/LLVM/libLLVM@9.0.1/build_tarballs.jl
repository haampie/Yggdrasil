version = v"9.0.1"

include("../common.jl")

name = "libLLVM"
sources = []
products = [
    LibraryProduct(["LLVM", "libLLVM"], :libllvm, dont_dlopen=true),
    ExecutableProduct("llvm-config", :llvm_config, "tools"),
]
platforms = expand_cxxstring_abis(supported_platforms())
script = raw"""
cd ${prefix}

# First, find (true) LLVM library directory in ~/.artifacts somewhere
LLVM_ARTIFACT_DIR=$(dirname $(dirname $(realpath $(ls ${libdir}/*LLVM*.${dlext} | head -1))))

# Clear out our `${prefix}`
rm -rf ${prefix}

# Copy over `llvm-config`, `libLLVM` and `include`, specifically.
mkdir -p ${prefix}/include ${prefix}/tools ${libdir}
cp -a ${LLVM_ARTIFACT_DIR}/include/llvm* ${prefix}/include/
cp -a ${LLVM_ARTIFACT_DIR}/tools/llvm-config* ${prefix}/tools/
cp -a ${LLVM_ARTIFACT_DIR}/$(basename ${libdir})/*LLVM*.${dlext}* ${libdir}
"""
dependencies = [
    # Depend explicitly upon a certain version of LLVM_full_jll
    BuildDependency(get_addable_spec("LLVM_full_jll", v"9.0.1+2")),
]

build_tarballs(ARGS, name, version, sources, script,
               platforms, products, dependencies)