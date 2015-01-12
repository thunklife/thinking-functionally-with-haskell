> double :: Integer -> Integer
> double = (2 *)

Given a function that doubles an integer what are the values of the following:
map (double . double) [1, 4, 4, 3]  = [4, 16, 16, 12]
map double [1, 4, 4, 3]             = [2, 8, 8, 6]
map double []                       = []

> sum' :: [Integer] -> Integer
> sum' = foldr (+) 0

Given a function that calculates the sum of a list of  integers, which of  the following are true:
sum . map double = double . sum     = true, doubling the sum of a list is the same as doubling all items and then calculating the sum
sum . map sum = sum . concat        = true, assumes a list of lists of integers. map sum will calculate the sums of the inner lists then sum those, sum . concat will flatten the list then sum it.
sum . sort = sum                    = true, addition is associative so the order doesn't matter.
