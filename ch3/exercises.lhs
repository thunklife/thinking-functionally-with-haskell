=============================================================================

Exercise A
----------

Which of the following equals 1
  -2 + 3 => 1
  3 + -2 => parse error on -2
  3 + (-2) => 1
  subtract 2 3 -1
  2 + subtract 3 => Num -> Num

Using flip, express subtract

> subtract' = flip (-)

=============================================================================

Exercise B
----------

Haskell provides three ways to define exponentation:
  (^)   :: (Num a, Integeral b) => a -> b -> a
  (^^)  :: (Fractional a, Integral b) => a -> b -> a
  (**)  :: (Floating a) => a -> a -> a

How would you define (^^)?

> exp' :: (Fractional a, Integral b) => a -> b -> a
> exp' x 1 = x
> exp' x y = exp' (x * abs x) (y -1)

=============================================================================

Exercise C
----------

Could you define div in the following way:

div :: Integral a => a -> a -> a
div x y = floor (x/y)

No because we constrained the type of a to Integral and / is only defined on Fractional

=============================================================================

Exercise D 
----------

Given this definition of floor:

> floor' :: Float -> Integer
> floor' = read . (takeWhile (/= '.')) . show

Explain why this definition doesn't work.

It doesn't work because of exponential/scientific notation for numbers

=============================================================================

Exercise E
----------

I have no idea

=============================================================================

Exercise F
----------

I have no idea

=============================================================================

Exercise G
----------

Given the type Nat below, make Nat an explicit instance of Ord

> data Nat = Zero | Succ Nat
>   deriving (Eq, Show)

> instance Ord Nat where
> Zero < Zero = False
> Zero < Succ n = True
> Succ n < Zero = False
> Succ n < Succ m = (n < m)

=============================================================================
