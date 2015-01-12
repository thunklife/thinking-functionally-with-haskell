In the 'common words' example, each letter was converted to lower case before computing the words. The expression to do this is words . map toLower.
Another way to do this is to get the words and the lower case each. What is the expression for that?

> import Data.Char

> lowerWords :: String -> [String]
> lowerWords = words . map toLower

> lowerWordsRev :: String -> [String]
> lowerWordsRev = map (map toLower) . words

That last one is hideous.
