module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (..)
import Json.Decode as Json exposing (Decoder)
import Json.Decode.Pipeline as Pipe exposing (..)


---- MODEL ----

type alias Model =
    {
        x: String,
        y: String,
    }

init : ( Model, Cmd Msg )
init =
    ( { x = "0", y = "0" }, Cmd.none )


---- UPDATE ----

type Msg
    = SetCoords Coords


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCoords pos ->
            ( { model | x = String.fromInt(pos.x), y = String.fromInt(pos.y)}, Cmd.none )


---- VIEW ----

view : Model -> Html Msg
view model =
    div [ class "main-container",
          on "mousemove" (Json.map SetCoords eventDecoder)
        ]
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text ("x: " ++ model.x) ]
        , h1 [] [ text ("x: " ++ model.x) ]
        ]

eventDecoder : Decoder Coords
eventDecoder =
    Json.map2 Coords
        (Json.at ["clientX"] Json.int)
        (Json.at ["clientY"] Json.int)

---- PROGRAM ----

main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
