type Matrix a = [Row a]
type Row a    = [a]

type Grid     = Matrix Digit
type Digit    = Char

digits :: [Char]
digits = ['1'..'9']

blank :: Digit -> Bool
blank = (== '0')

