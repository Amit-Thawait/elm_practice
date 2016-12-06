module Main exposing (..)

import Html


cart =
    [ { name = "Lemon", price = 0.5, qty = 1, discounted = False }
    , { name = "Apple", price = 1.0, qty = 5, discounted = False }
    , { name = "Pear", price = 1.25, qty = 10, discounted = False }
    ]


discount minQty discPct item =
    if not item.discounted && item.qty >= minQty then
        { item
            | price = item.price * (1.0 - discPct)
            , discounted = True
        }
    else
        item


newCart =
    List.map ((discount 10 0.3) >> (discount 5 0.2)) cart


main =
    Html.text (toString newCart)
