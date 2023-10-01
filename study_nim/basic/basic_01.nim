type
  Point = object
    x: float64
    y: float64

# Overloading the '$' operator for Point
proc `$`(p: Point): string =
  return "Point(x: " & $p.x & ", y: " & $p.y & ")"


# Initialize an array of `Point` objects with specified values
var points = [
  Point(x: 0.0, y: 0.0),
  Point(x: 1.0, y: 1.0),
  Point(x: 2.0, y: 2.0),
  Point(x: 3.0, y: 3.0),
  Point(x: 4.0, y: 4.0)
]

# Alternatively, you can explicitly specify the type if needed
# var points: array[_, Point] = ...

proc foo(points: var openArray[Point] ) =
  echo "hello"
  #for i in 0..< points.len:
  # below is simpler
  for i, point in points:
    #echo "Point ", i, ": (", points[i].x, ", ", points[i].y, ")"
    # below need you implement overloaing $ operator
    echo "Point ", i, " ", points[i]


foo(points)

