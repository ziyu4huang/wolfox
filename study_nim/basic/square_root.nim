import math

proc solveQuadratic(a, b, c: float): tuple[root1: float, root2: float, hasRealRoots: bool] =
  let discriminant = b * b - 4.0 * a * c

  if discriminant < 0.0:
    return (root1: 0.0, root2: 0.0, hasRealRoots: false)
  else:
    let root1 = (-b + sqrt(discriminant)) / (2.0 * a)
    let root2 = (-b - sqrt(discriminant)) / (2.0 * a)
    return (root1: root1, root2: root2, hasRealRoots: true)

# Test the function
let a = 1.0
let b = -3.0
let c = 2.0

let result = solveQuadratic(a, b, c)

if result.hasRealRoots:
  echo "Roots are: ", result.root1, " and ", result.root2
else:
  echo "No real roots."

