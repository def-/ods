import algorithm
# TODO: use array instead?

type BinaryHeap*[T] = object
  a: seq[T]
  n: int

proc left(i: int): int =
  2*i + 1

proc right(i: int): int =
  2*i + 2

proc parent(i: int): int =
  (i-1) div 2

proc resize[T](h: BinaryHeap[T]): T =
  h.a.resize(max(2*h.n, 1))

proc findMin*[T](h: BinaryHeap[T]): T =
  h.a[0]

proc size*[T](h: BinaryHeap[T]): int =
  h.n

proc bubbleUp[T](h: var BinaryHeap[T], i: int) =
  var p = parent(i)
  var i = i
  while i > 0 and cmp(h.a[i], h.a[p]) < 0:
    swap h.a[i], h.a[p]
    i = p
    p = parent(i)

proc trickleDown[T](h: var BinaryHeap[T], i: int) =
  var i = i
  while true:
    var j = -1
    let r = right(i)
    if r < h.n and cmp(h.a[r], h.a[i]) < 0:
      let l = left(i)
      if cmp(h.a[l], h.a[r]) < 0:
        j = l
      else:
        j = r
    else:
      let l = left(i)
      if l < h.n and cmp(h.a[l], h.a[i]) < 0:
        j = l

    if j >= 0: swap h.a[i], h.a[j]
    i = j
    if i < 0: break

proc initBinaryHeap*[T]: BinaryHeap[T] =
  result.a = @[]
  result.n = 0

proc initBinaryHeap*[T](b: seq[T]): BinaryHeap[T] =
  result.a = b # TODO: Copies are bad
  result.n = result.a.len
  for i in countdown(result.n div 2 - 1, 0):
    result.trickleDown(i)

proc remove*[T](h: var BinaryHeap[T]): T =
  result = h.a[0]
  dec h.n
  h.a[0] = h.a[h.n]
  h.trickleDown(0)
  if 3*h.n < h.a.len: h.resize()

proc sort*[T](b: var seq[T]) =
  var h = initBinaryHeap(b);
  while h.n > 1:
    dec h.n
    swap h.a[h.n], h.a[0]
    h.trickleDown(0)

  b = h.a # TODO: Copies are bad
  b.reverse()
