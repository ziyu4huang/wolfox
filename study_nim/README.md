

[SIMD](https://stackoverflow.com/questions/11228855/header-files-for-x86-simd-intrinsics)

Historically (before immintrin.h pulled in everything) you had to manually include a header for the highest level of intrinsics you wanted.
This may still be useful with MSVC and ICC to stop yourself from using instruction-sets you don't want to require.

```
<mmintrin.h>  MMX
<xmmintrin.h> SSE
<emmintrin.h> SSE2
<pmmintrin.h> SSE3
<tmmintrin.h> SSSE3
<smmintrin.h> SSE4.1
<nmmintrin.h> SSE4.2
<ammintrin.h> SSE4A
<wmmintrin.h> AES
<immintrin.h> AVX, AVX2, FMA
```
