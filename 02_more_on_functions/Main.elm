module Main exposing (..)

import Html


-- Any function name with non alphanumeric characters as considered as infix functions in elm


(~+) a b =
    a + b + 0.1


result =
    -- (~+) 1 2
    1 ~+ 3


main =
    Html.text (toString result)
