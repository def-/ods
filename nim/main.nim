import algorithms,
  times, math, algorithm
randomize()

proc isSorted[T](a: openarray[T]): bool =
  result = true
  for i in 0 .. <a.high:
    if a[i] > a[i+1]:
      return false

proc sortTests(n: int) =
  var
    start, stop: float
    a = newSeq[int](n)

  for i in 0..a.high:
    a[i] = random(int.high)
  stdout.write "Sorting ", n, " elements using quickSort..."
  flushFile stdout
  start = cpuTime()
  quickSort(a)
  stop = cpuTime()
  echo "done (", stop-start, "s)"
  assert isSorted(a)

  for i in 0..a.high:
    a[i] = random(int.high)
  stdout.write "Sorting ", n, " elements using heapSort..."
  flushFile stdout
  start = cpuTime()
  heapSort(a)
  stop = cpuTime()
  echo "done (", stop-start, "s)"
  assert isSorted(a)

  for i in 0..a.high:
    a[i] = random(int.high)
  stdout.write "Sorting ", n, " elements using mergeSort..."
  flushFile stdout
  start = cpuTime()
  mergeSort(a)
  stop = cpuTime()
  echo "done (", stop-start, "s)"
  assert isSorted(a)

  for i in 0..a.high:
    a[i] = random(int.high)
  stdout.write "Sorting ", n, " elements using built in sort..."
  flushFile stdout
  start = cpuTime()
  sort(a, cmp[int])
  stop = cpuTime()
  echo "done (", stop-start, "s)"
  assert isSorted(a)

  #for i in 0..a.high:
  #  a[i] = random(int32.high)
  #stdout.write "Sorting ", n, " elements using radixSort..."
  #flushFile stdout
  #start = cpuTime()
  #radixSort(a)
  #stop = cpuTime()
  #echo "done (", stop-start, "s)"
  #assert isSorted(a)

sortTests(1000000)
