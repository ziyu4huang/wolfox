import math
from math import sqrt

fn rsqrt[dt: DType, width: Int](x: SIMD[dt, width]) -> SIMD[dt, width]:
    return 1 / sqrt(x)

fn main():
    let a = rsqrt[DType.float16, 4](42)
    let b = rsqrt(SIMD[DType.float16, 4](42, 23, 21, 1))
    print(a)
    print(b)


