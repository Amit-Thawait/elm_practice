module Main exposing (..)

import Html
import String


capitalize name maxlength =
    if String.length name > maxlength then
        String.toUpper name
    else
        name


main =
    let
        name =
            "Amit Thawait"

        length =
            String.length name
    in
        capitalize name 10
            ++ " - name length : "
            ++ toString length
            |> Html.text
