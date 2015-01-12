Define a function of type:

anagrams :: Int -> [Word] -> String

That, when given a list of english words, extracts the n-letter words and produces a string of anagrams for the n-letter words.
Do not define the functions, simply types and names

anagrams :: Int -> [Word] -> String
anagrams n = concat . map showAnagrams . map makeAnagrams . filter (beginsWith letters!!n)

makeAnagrams :: Word -> (Word, [Anagram])
showAnagrams :: (Word, [Anagram]) -> String
beginsWith :: Char -> Word -> Bool
