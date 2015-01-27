=============================================================================

Exercise A
----------

Which of the following holds true for all xs:

[]:xs = xs              => false
[]:xs = [[],xs]         => false
xs:[] = xs              => false
xs:[] = [xs]            => true
xs:xs = [xs,xs]         => false
[[]] ++ xs = xs         => false
[[]] ++ xs = [[],xs]    => false
[[]] ++ [xs] = [[], xs] => true
[xs] ++ [] = [xs]       => true

=============================================================================

Exercise B
----------

Does the following list comprehension create an infinite list of DISTINCT pairs?

[(x,y) | x <- [0..], y <- [0..]]

No. The comprehension will begin and 0 and then create a pair using every element from the second infinite list. 
That second list will never terminate, so you'll end up with 0 paired with an inifinite number of numbers.

=============================================================================

Exercise C
----------

Give the defintion of the function disjoint :: (Ord a) => [a] -> [a] -> Bool, which takes two sorted lists and 
determines if they have an element in common

> disjoint :: (Ord a) => [a] -> [a] -> Bool
> disjoint ys = foldr (\x a -> a || elem x ys) False

=============================================================================

Exercise D
----------

Under what conditions do the following two list comprehensions return the same result
[e | x <- xs, p x, y <-ys]
[e | x <- xs, y <- ys, p x]

The don't return anything, they're not valid expressions becaue e is not in scope.

=============================================================================

Exercise E
----------

1729 is first number that can be expressed as two cubes in different ways:

1^3 + 12^3 = 9^3 + 10^3 = 1729.

Define a function that returns a list of essentially different quadruples (a,b,c,d) where 0 < a,b,c,d <= n such that
a^3 + b^3 = c^3 + d^3. Make sure to consider what makes a tuple essentially different

> type Quadruple = (Int, Int, Int, Int)
> quads :: Int -> [Quadruple]
> quads n = [(a,b,c,d) | a <- [1..n], b <- [a+1..n], c <- [a*2..n], d <- [c+1..n], (a^3 + b^3) == (c^3 + d^3)]

I have no idea why this works, but it gives the same output as the solution in the book:

  quads n = [(a,b,c,d) | a <- [1..n], b <- [a..n], c <- [a+1..n], d <- [c..n], (a^3 + b^3) == (c^3 + d^3)]
=============================================================================

Exercise F
----------

The dual view of lists is to construct them by adding elements to the end of the list

> data DualList a = Nil | Snoc (DualList a) a
>  deriving (Show)

Define the following functions for the DualList

dualHead :: DualList a -> a
dualLast :: DualList a -> a
toDualList :: [a] -> DualList a
fromDualList :: DualList a -> [a]

> dualHead :: DualList a -> a
> dualHead (Snoc Nil x) = x
> dualHead (Snoc xs x) = dualHead xs

> dualLast :: DualList a -> a
> dualLast (Snoc xs x) = x

> toDualList :: [a] -> DualList a
> toDualList = convert . reverse
>   where convert [] = Nil
>         convert (x:xs) = Snoc (convert xs) x

> fromDualList :: DualList a -> [a]
> fromDualList Nil = []
> fromDualList (Snoc xs x) = (fromDualList xs) ++ [x]

Alternate fromDualList

> fromDualList' :: DualList a -> [a]
> fromDualList' = reverse . convert
>   where convert Nil = []
>         convert (Snoc xs x) = x:convert xs

=============================================================================

Exercise G
----------

How much space is required to evaluate length xs?

Assuming length is defined as:

length [] = 0
length (_:xs) = 1 + length xs

Space required is linear

Consider the following implementation of length

> length' :: [a] -> Int
> length' xs = loop(0,xs)
>   where loop (n, []) = n
>         loop (n, x:xs) = loop(n+1,xs)

Does this implementation change teh space requirement? 
Although this is tail recursive, under lazy evaluation the space is still linear.

Does it change if we switched to eager evaluation?
Under strict evaluation the tail call is optimized and the space is constant.

=============================================================================

Exercise H
----------

The function take n returns the first n elements in a list. The function drop n drops the first n elements. Write recursive definitions of both

> takeN :: Int -> [a] -> [a]
> takeN _ [] = []
> takeN 0 _ = []
> takeN n (x:xs) = x:(takeN (n-1) xs)

> dropN :: Int -> [a] -> [a]
> dropN _ [] = []
> dropN 0 xs = xs
> dropN n (x:xs) = drop (n-1) xs

Based on these definitions, what are the vaules of

  takeN 0 undefined     The result an exception 
  takeN undefined []    The result is an empty list

Which of the following are true for all integers m and n

  take n xs ++ drop n xs == xs                True
  take m . drop n = drop n . take (m + n)     True
  take m . take n = take (m `min` n)          True
  drop m . drop n = drop (m + n)              True

The standard prelude provides the splitAt n function defined as

  splitAt n xs = (take n xs, drop n xs)

This is inefficient because it processes the list twice. Implement splitAt n so that it only traverses the list once.

> splitAt' :: Int -> [a] -> ([a],[a])
> splitAt' _ [] = ([],[])
> splitAt' 0 xs = ([], xs)
> splitAt' n (x:xs) = (x:ys, zs)
>   where (ys,zs) = splitAt' (n-1) xs

=============================================================================

Exercise H
----------

Given the equation
  map (f . g) xs = map f (map g xs)

Which of the following statements do you agree with? Which do you disagree with?

  It's not true for all xs; it depends on if xs is finite     False. This is the associativity law for functors, the equation is true for all functors
  It's not true for all f and g; it depends on whether f and g are strict.    False.
  It's true for all xs f and g of appropriate types.    True
  It looks true but it has to be proved so from the definition of map and composition.  This feels false to me. map and compose are well defined mathematical concepts. Book says True.
  Used right-to-left it is an optimisation.     True, "loop fusion"
  It's not an optimization under lazy evaluation.     False.
  Whether or not it is computed in pieces or in whole the right-hand side produces an intermediate list.    This feels false. Book says True

=============================================================================

Exercise J
----------

At least one of the following equations is false; which are true and which are false?

  map f . take n        = take n . map f                                  True
  map f . reverse       = reverse . map f                                 True
  map f . sort          = sort . map f                                    False - Only true if f preserves order
  map f . filter p      = map fst . filter snd . map (fork (f, p))        True
  filter (p . g)        = map (invertg) . filter p . map g                True
  reverse . concat      = concat . reverse . map reverse                  True
  filter p . concat     = concat . map (filter p)                         True

=============================================================================

Exercise K
----------

What are the types of the following functions

  unzip = fork (map fst, map snd)               unzip :: [(a,b)] -> ([a], [b])
  cross (f,g) = fork (f . fst, g . snd)         cross :: (a -> b, c -> d) -> (a,c) -> (b,d)

Provide a simple equational reasoning that

  cross (map f,map g) . unzip = unzip . map (cross (f,g))         I can't.

=============================================================================

Exercise L
----------

Continuing from the previous exercise, prove that

  cross (f,g) . cross (h,k) = cross (f . h, g . k)        I can't

cross (f,g) has functor-like properties. It's a bi-functor

> class Bifunctor p where
>   bimap :: (a -> b) -> (c -> d) -> p a c -> p b d

Arguments are given to the bifuctor one-by-one rather than a pair. Make the following type an instance of Bifunctor

> newtype Pair a b = Pair { getPair :: (a,b)}
>   deriving (Show)
> 
> instance Bifunctor Pair where
>   bimap f g (Pair (x,y)) = Pair (f x, g y)

Make the following type an instance of Bifunctor

> data Either' a b = Left' a | Right' b
>
> instance Bifunctor Either' where
>   bimap f _ (Left' a) = Left' (f a)
>   bimap _ g (Right' b) = Right' (g b)

=============================================================================
