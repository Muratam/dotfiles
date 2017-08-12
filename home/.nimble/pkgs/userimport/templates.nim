import sequtils,strutils,strscans,algorithm,math,future,sets,queues,tables,macros
macro unpack*(rhs: seq,cnt: static[int]): auto =
  let t = genSym(); result = quote do:(let `t` = `rhs`;())
  for i in 0..<cnt: result[0][1].add(quote do:`t`[`i`])
template get*():string = stdin.readLine()
template times*(n:int,body:untyped): untyped = (for _ in 0..<n: body)
template `max=`*(x,y:typed):void = x = max(x,y)
template `min=`*(x,y:typed):void = x = min(x,y)

# future: dump / lc[(x,y,z) | (x <- 1..n, y <- x..n, z <- y..n, x*x + y*y == z*z),tuple[a,b,c: int]]
### template assignOperators():untyped =
template `%=`*(x,y:typed):void = x = x mod y
template `//=`*(x,y:typed):void = x = x div y
template `gcd=`*(x,y:typed):void = x = gcd(x,y)
template `lcm=`*(x,y:typed):void = x = lcm(x,y)
# set(+union(or) | *intersect(and) )
proc `+=`[T](x:var set[T],y:T):void = x.incl(y)
proc `-=`[T](x:var set[T],y:T):void = x.excl(y)
proc `+=`[T](x:var set[T],y:set[T]):void = x = x.union(y)
proc `*=`[T](x:var set[T],y:set[T]):void = x = x.intersection(y)
proc `-=`[T](x:var set[T],y:set[T]):void = x = x.difference(y)
converter toInt8(x:int) : int8 = x.toU8()



### template iterations():untyped =
template rep*(i:untyped,n:int,body:untyped):untyped =
  block:(var i = 0; while i < n:( body; i += 1))
template each*[T](arr:var seq[T],a,body:untyped):untyped =
  for i in 0..<arr.len:(var a{.inject.}=arr[i]; body; defer:arr[i]=a)
template each*[T](arr:var seq[T],i,a,body:untyped):untyped =
  for i in 0..<arr.len:(var a{.inject.}=arr[i]; body; defer:arr[i]=a)
template eachIt*[T](arr:var seq[T],body:untyped):untyped =
  for i in 0..<arr.len:(var it{.inject.}=arr[i]; body; defer:arr[i]=it)
template eachIt*[T](arr:var seq[T],i,body:untyped):untyped =
  for i in 0..<arr.len:(var it{.inject.}=arr[i]; body; defer:arr[i]=it)

# matrix library
proc transpose*[T](mat:seq[seq[T]]):seq[seq[T]] =
  result = newSeqWith(mat[0].len,newSeq[T](mat.len))
  for x,xs in mat: (for y,ys in xs:result[y][x] = mat[x][y])