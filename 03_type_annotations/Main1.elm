module Main exposing (..)

import Html


cart =
    [ { name = "Lemon", price = 0.5, qty = 1, discounted = False }
    , { name = "Apple", price = 1.0, qty = 5, discounted = False }
    , { name = "Pear", price = 1.25, qty = 10, discounted = False }
    ]


fiveOrMoreDiscount item =
    if item.qty >= 5 then
        { item
            | price = item.price * 0.8
            , discounted = True
        }
    else
        item


newCart =
    List.map fiveOrMoreDiscount cart


main =
    Html.text (toString newCart)
