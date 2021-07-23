module Page.ItemPage exposing (Model, view)

import Browser exposing (Document)
import Html exposing (Html, div, text)
import Item exposing (Item)


type alias Model =
    { title : String
    , item : Item
    }


view : Model -> Document Never
view model =
    { title = model.title
    , body =
        [ div
            []
            [ text <| "this is item " ++ String.fromInt model.item.number
            ]
        ]
    }
