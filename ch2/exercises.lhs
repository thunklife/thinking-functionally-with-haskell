> import Data.Char

=============================================================================

Exercise A
----------
'Is half of two plus two equal to two or three?'

Yes.

=============================================================================

Exercise B
----------
Some of the following expresions are not syntactically correct, others are correct but not well-formed (have no-sensible type), others are well-formed. Indicate which is which and for any well formed expression, provide the type. Assume

double :: Int -> Int

[0,1)                       -> Not syntactically correct
double -3                   -> Not syntactically correct
double double 0             -> Not well formed
if 1 == 0 then 2 == 1       -> Not syntactically correct
"++" == "+" ++ "+"          -> Bool
[(+), (-)]                  -> [(Int -> Int)]
[[], [[]], [[[]]]           -> Not well formed
concat ["tea", "for", '2']  -> Not well formed
concat ["tea", "for", "2"]  -> [Char]

=============================================================================

Excercise C
-----------
Write a function

modernize :: String -> String

which will take a string, and ensure that the first letter of each word is capitialized. Consider the following questions beforehand

1. The function toLower converts a character to lowercase, what do you think the name of the function that converts to uppercase is called?

  toUpper

2. The function words takes a String and returns a list of words ([String]). What do you think unwords does?

  concatenates a list of words back to a string with spaces added appropriately.

3. The function head returns the first element in a list, the function tail returns all elements but the head. How could you use these to reconstruct a list?

  f xs = head xs : tail xs
  If you had x and xs you could [x] ++ xs, but you could also just x:xs if you have both so...

> import Data.Char
> modernize :: String -> String
> modernize = unwords . map uppercase . words
>    where uppercase w = toUpper (head w) : tail w

=============================================================================

Exercise D
----------

Given the expression

head (map f xs)

How many times would f be evaluated if using strict evaluation? How many times if using lazy evaluation?
  Strict: n (once for every element in the list)
  Lazy: once because head only takes one element

In strict evaluation, what would be preferred to head . map f?
  f . head

The filter function finds elements in a list that satisfy some predicate (p), it has this type

filter :: (a -> Bool) -> [a] -> [a]

Suppose you had the expression

head . filter p

Why would you not want to evaluate that strictly?
  You have to filter the entire list before taking the head. With lazy evaluation, you stop once you've reach the first match.

In strict evaluation, you'd prefer something like

> first :: (a->Bool) -> [a] -> a
> first p xs | null xs = error "Empty List"
>            | p x = x
>            | otherwise = first p (tail xs)
>             where x = head xs

Given the expression

head . filter p . map f

What would be a preferred way to right that for strict evaluation.

> first' :: (a -> b) -> (b -> Bool) -> [a] -> b
> first' f p xs | null xs = error "Empty List"
>               | p y = y
>               | otherwise = first' f p (tail xs)
>               where x = head xs
>                     y = f x

=============================================================================

Exercise E
----------

The type Maybe is declared like so

data Maybe a = Nothing | Just a
                deriving (Eq, Ord)

Give a suitable definition for first that returns Maybe a

> firstM :: (a -> Bool) -> [a] -> Maybe a
> firstM _ [] = Nothing
> firstM p (x:xs) | p x = Just x
>                 | otherwise = firstM p xs

=============================================================================

Exercise F
----------

No clue

=============================================================================

Exercise G
----------

Suppose a Date is represented by three integers (month, day, year), write a function that takes a Date and returns a string such as "10th December, 2013"

> months :: [String]
> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
> type Date = (Int, Int, Int)
> showDate :: Date -> String
> showDate (m, d, y) = (show d) ++ dateSuffix d ++ " " ++ (months !! (m-1)) ++ ", " ++ (show y)

> dateSuffix :: Int -> String
> dateSuffix d | d >= 10 = "th" 
>              | x == 0 = "nd"
>              | x == 1 = "st"
>              | x == 3 = "rd"
>              | otherwise = "th"
>   where x = d `mod` 2

=============================================================================

Exercise H
----------

Suppose a credit card company issues cards with ten digit id numbers (CIN). The first 8 digits are arbitrary, the last 2 are the sum of the
previous 8 (checksum). Write a function that takes an 8 digit string, calculates the checksum, and produces a complete 10 digit CIN.

> type CIN = String
> addSum :: CIN -> CIN
> addSum xs = xs ++ (show . sum $ map digitToInt xs)

> valid :: CIN -> Bool
> valid "" = False
> valid c = c == (addSum $ take 8 c)

=============================================================================

Exercise I
----------

Write an interactive program that takes a string and tests if it is a palindrome (excluding punctuation).

> palindrome :: IO ()
> palindrome = putStrLn "Enter a string" >> getLine >>= putStrLn . show . isPalindrome . filter isAlpha

> isPalindrome :: String -> Bool
> isPalindrome s = t == (reverse t)
>   where t = map toLower $ filter isAlpha s

=============================================================================
