import math
from math import sqrt

fn rsqrt[dt: DType, width: Int](x: SIMD[dt, width]) -> SIMD[dt, width]:
    return 1 / sqrt(x)

fn main():
    # mojo can auto convert int to SIMD[int, 4]
    let a = rsqrt[DType.float16, 4](42)
    # we can also create SIMD value , to let rsqrt handle
    let b = rsqrt(SIMD[DType.float16, 4](42, 23, 21, 1))
    print(a)
    print(b)


