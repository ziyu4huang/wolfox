proc quickSort(arr: var openArray[int], low: int, high: int) =
  if low < high:
    var pivot = arr[high]
    var i = low - 1

    for j in low ..< high:
      if arr[j] < pivot:
        inc(i)
        swap(arr[i], arr[j])

    swap(arr[i + 1], arr[high])

    let pi = i + 1

    quickSort(arr, low, pi - 1)
    quickSort(arr, pi + 1, high)

# Test the quickSort procedure
var arr = @[9, 7, 5, 11, 12, 2, 14, 3, 10, 6]
echo "Before sorting: ", arr
quickSort(arr, 1, arr.high)
echo "After sorting: ", arr

