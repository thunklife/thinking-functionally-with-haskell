The type Char is denoted using single quotes, the type String is denoted using double quotes.
String is the same as [Char].

The expressions 'H' and "H" have different types, what are they?
'H' :: Char
"H" :: [Char]

What are the differences between 2001 and "2001"?
The former has the type Num, while the latter has the type [Char].

The operation ++ concatenates two lists. Simplify:
[1,2,3] ++ [3,2,1]          = [1,2,3,3,2,1]
"Hello" ++ "World"          = "HelloWorld"
[1,2,3] ++ []               = [1,2,3]
"Hello" ++ "" ++ "World"    = "HelloWorld"
