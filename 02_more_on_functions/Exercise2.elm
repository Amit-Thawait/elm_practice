module Main exposing (..)

import Html
import String


(~=) string1 string2 =
    String.left 1 string1 == String.left 1 string2


main =
    (~=) "Amit" "Ankit"
        |> toString
        |> Html.text
