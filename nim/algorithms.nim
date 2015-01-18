import binaryHeap,
  math

proc quickSort*[T](a: var openarray[T], i, n: int) =
  if n <= 1: return
  let x = a[i + random(n)]
  var
    p = i-1
    j = i
    q = i+n
  # a[i..p]<x,  a[p+1..q-1]??x, a[q..i+n-1]>x
  while j < q:
    let comp = cmp(a[j], x)
    if comp < 0:   # move to beginning of array
      inc p
      swap a[j], a[p]
      inc j
    elif comp > 0: # move to end of array
      dec q
      swap a[j], a[q]
    else:          # keep in the middle
      inc j
  # a[i..p]<x,  a[p+1..q-1]=x, a[q..i+n-1]>x
  quickSort a, i, p-i+1
  quickSort a, q, n-q+i

proc quickSort*[T](a: var openarray[T]) =
  quickSort(a, 0, a.len)

proc heapSort*[T](a: var seq[T]) =
  binaryHeap.sort(a)

proc merge[T](a0, a1: openarray[T], a: var openarray[T]) =
  var i0, i1 = 0
  for i in 0 .. a.high:
    if i0 == a0.len:
      a[i] = a1[i1]
      inc i1
    elif i1 == a1.len:
      a[i] = a0[i0]
      inc i0
    elif cmp(a0[i0], a1[i1]) < 0:
      a[i] = a0[i0]
      inc i0
    else:
      a[i] = a1[i1]
      inc i1

proc mergeSort*[T](a: var seq[T]) =
  if a.len <= 1: return
  var a0 = a[0 .. <(a.len div 2)]
  var a1 = a[a.len div 2 .. a.high]
  mergeSort(a0)
  mergeSort(a1)
  merge(a0, a1, a)

# TODO: This is wrong, why?
proc radixSort*(a: var openarray[int]) =
  let d = 8
  let w = 32
  for p in 0 .. < w div d:
    var c = newSeq[int](1 shl d)
    # the next three for loops implement counting-sort
    var b = newSeq[int](a.len)
    for i in 0 .. a.high:
      inc c[(a[i] shr d*p) and ((1 shl d) - 1)]
    for i in 1 .. <(1 shl d):
      c[i] += c[i-1]
    for i in countdown(a.len-1, 0):
      let x = (a[i] shr d*p) and ((1 shl d) - 1)
      dec c[x]
      b[c[x]] = a[i]
    a = b
