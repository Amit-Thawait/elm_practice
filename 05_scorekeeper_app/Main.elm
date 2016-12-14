module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { players : List Player
    , name : String
    , playerID : Maybe Int
    , plays : List Play
    }


type alias Player =
    { id : Int
    , name : String
    , points : Int
    }


type alias Play =
    { id : Int
    , playerID : Int
    , name : String
    , points : Int
    }


initModel : Model
initModel =
    { players = []
    , name = ""
    , playerID = Nothing
    , plays = []
    }



-- update


type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            -- Debug.log "Input "
            { model | name = name }

        Cancel ->
            { model | name = "", playerID = Nothing }

        Save ->
            if String.isEmpty model.name then
                model
            else
                save model

        Score player points ->
            addScore model player points

        Edit player ->
            { model | name = player.name, playerID = Just player.id }

        DeletePlay play ->
            deletePlay model play


deletePlay : Model -> Play -> Model
deletePlay model play =
    let
        newPlays =
            List.filter (\p -> p.id /= play.id) model.plays

        newPlayers =
            List.map
                (\player ->
                    if player.id == play.playerID then
                        { player | points = player.points - play.points }
                    else
                        player
                )
                model.players
    in
        { model
            | players = newPlayers
            , plays = newPlays
        }


addScore : Model -> Player -> Int -> Model
addScore model scorer points =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == scorer.id then
                        { player
                            | points = player.points + points
                        }
                    else
                        player
                )
                model.players

        play =
            Play (List.length model.plays) scorer.id scorer.name points
    in
        { model
            | players = newPlayers
            , plays = play :: model.plays
        }


save : Model -> Model
save model =
    case model.playerID of
        Just id ->
            edit model id

        Nothing ->
            add model


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }
                    else
                        player
                )
                model.players

        newPlays =
            List.map
                (\play ->
                    if play.playerID == id then
                        { play | name = model.name }
                    else
                        play
                )
                model.plays
    in
        { model
            | players = newPlayers
            , plays = newPlays
            , name = ""
            , playerID = Nothing
        }


add : Model -> Model
add model =
    let
        player =
            Player (List.length model.players) model.name 0

        newPlayers =
            player :: model.players
    in
        { model
            | players = newPlayers
            , name = ""
        }



-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ]
        , playerSection model
        , playerForm model
        , playSection model
          -- , p [] [ text (toString model) ]
        ]


playSection : Model -> Html Msg
playSection model =
    div []
        [ playListHeader
        , playList model
        ]


playListHeader : Html Msg
playListHeader =
    header []
        [ div [] [ text "Plays" ]
        , div [] [ text "Points" ]
        ]


playList : Model -> Html Msg
playList model =
    model.plays
        |> List.map playLi
        |> ul []


playLi : Play -> Html Msg
playLi play =
    li []
        [ i
            [ class "remove"
            , onClick (DeletePlay play)
            ]
            []
        , div [] [ text play.name ]
        , div [] [ text (toString play.points) ]
        ]


playerSection : Model -> Html Msg
playerSection model =
    div []
        [ playerListHeader
        , playerList model
        , pointTotal model
        ]


playerListHeader : Html Msg
playerListHeader =
    header []
        [ div [] [ text "Name" ]
        , div [] [ text "Points" ]
        ]


playerList : Model -> Html Msg
playerList model =
    -- ul []
    --     (List.map playerLi model.players)
    model.players
        |> List.sortBy .name
        |> List.map (playerLi model.playerID)
        |> ul []


playerLi : Maybe Int -> Player -> Html Msg
playerLi editPlayerID player =
    li []
        [ i
            [ class "edit"
            , onClick (Edit player)
            ]
            []
        , div [ class (editPlayerClass editPlayerID player) ]
            [ text player.name ]
        , button
            [ type_ "button"
            , onClick (Score player 2)
            ]
            [ text "2pt" ]
        , button
            [ type_ "button"
            , onClick (Score player 3)
            ]
            [ text "3pt" ]
        , div []
            [ text (toString player.points) ]
        ]


pointTotal : Model -> Html Msg
pointTotal model =
    let
        total =
            List.map .points model.players
                |> List.sum
    in
        footer []
            [ div [] [ text "Total:" ]
            , div [] [ text (toString total) ]
            ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input
            [ type_ "text"
            , placeholder "Add/Edit Player..."
            , onInput Input
            , value model.name
            , class (editInputClass model.playerID)
            ]
            []
        , button [ type_ "submit" ] [ text "Save" ]
        , button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ]


editInputClass : Maybe Int -> String
editInputClass editPlayerID =
    case editPlayerID of
        Just id ->
            "edit"

        Nothing ->
            ""


editPlayerClass : Maybe Int -> Player -> String
editPlayerClass editPlayerID player =
    case editPlayerID of
        Just id ->
            if player.id == id then
                "edit"
            else
                ""

        Nothing ->
            ""


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
