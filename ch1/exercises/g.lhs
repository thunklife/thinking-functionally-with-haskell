Here is a song:

One man went to mow
Went to mow a meadow
One man and his dog
Went to mow a meadow

Two men went to mow
Went to mow a meadow
Two men, one man and his dog
Went to mow a meadow

...

Define a function with the type

song :: Int -> String

Calling song n will produce a version of the song above for n men, assume n < 10.

> numbers :: [String]
> numbers = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]

> song :: Int -> String
> song 0 = ""
> song n = song (n-1) ++ "\n" ++ verse n

> verse :: Int -> String
> verse n = line1 n ++ line2 n ++ line3 n ++ line4 n

> line1 :: Int -> String
> line1 n = numbers!!(n-1) ++ subject n ++ " went to mow"

> line2 :: Int -> String
> line2 _ = "Went to mow a meadow"

> line3 :: Int -> String
> line3 1 = "One man and his dog"
> line3 n = go n ++ ", one man and his dog"
>   where go 0 = ""
>         go n = (numbers!!(n-1) ++ subject n) ++ ", " ++ go (n-1)

> line4 :: Int -> String
> line4 _ = "Went to mow a meadow"

> subject :: Int -> String
> subject n
>    | n == 1 = " man"
>    | otherwise = " men"
