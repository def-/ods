import algorithm
# TODO: use array instead?

type ArrayStack[T] = object
  a: seq[T]
  n: int

proc size*[T](s: ArrayStack[T]): int =
  s.n

proc get*[T](s: ArrayStack[T], i: int): int =
  s.a[i]

proc set*[T](s: var ArrayStack[T], i: int, x: T) =
  s.a[i] = x

proc clear*[T](s: var ArrayStack[T], i: int, x: T) =
  s.n = 0
  s.a.clear()

proc initArrayStack*[T]: ArrayStack[T] =
  result.a = newSeq[T](1)
