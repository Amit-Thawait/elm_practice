module Main exposing (..)

import Html
import String


(~=) string1 string2 =
    String.left 1 string1 == String.left 1 string2



-- result =
--     "Amit" ~= "Ajay"
-- main =
--     Html.text (toString result)


main =
    "Amit"
        ~= "Ankit"
        |> toString
        |> Html.text
