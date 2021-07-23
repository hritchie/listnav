module Page.ItemPage exposing (Model, view)

import Browser exposing (Document)
import Html exposing (Html)
import Item exposing (Item)


type alias Model =
    { title : String
    , item : Item
    }


view : Model -> Document Never
view model =
    Debug.todo ""
