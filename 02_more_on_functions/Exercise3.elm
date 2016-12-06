module Main exposing (..)

import Html
import String
import List


sentence =
    "My name is Amit Thawait. I am a software developer."


wordCount =
    String.words >> List.length


main =
    sentence
        |> wordCount
        |> toString
        |> Html.text
