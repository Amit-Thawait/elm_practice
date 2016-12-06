module Main exposing (..)

import Html


-- These are default imports. Refer : http://package.elm-lang.org/packages/elm-lang/core/latest
-- import String
-- import List


sentence =
    "My name is Amit Thawait. I am a software developer."


wordCount =
    String.words >> List.length


main =
    sentence
        |> wordCount
        |> toString
        |> Html.text
