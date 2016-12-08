module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { calorie : Int
    , input : Int
    , error : Maybe String
    }



-- model


initModel : Model
initModel =
    { calorie = 0, input = 0, error = Nothing }



-- update


type Msg
    = AddCalorie
    | Input String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | calorie = model.calorie + model.input
                , input = 0
            }

        Input val ->
            case String.toInt val of
                Ok value ->
                    { model | input = value, error = Nothing }

                Err err ->
                    { model | input = 0, error = Just err }

        Clear ->
            initModel



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text ("Total Calories " ++ toString model.calorie) ]
        , div []
            [ input
                [ type_ "text"
                , onInput Input
                , value
                    (if model.input == 0 then
                        ""
                     else
                        toString model.input
                    )
                ]
                []
            ]
        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button [ type_ "button", onClick AddCalorie ] [ text "Add" ]
        , button [ type_ "button", onClick Clear ] [ text "Clear" ]
        ]


main : Program Never Model Msg
main =
    beginnerProgram { model = initModel, view = view, update = update }
