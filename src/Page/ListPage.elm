module Page.ListPage exposing
    ( Model
    , initialModel
    , view
    )

import Browser exposing (Document)
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (classList, href)
import Item exposing (Item)


type alias Model =
    { title : String
    , items : List Item
    , selectedItemNumber : Maybe Int
    }


initialModel : Model
initialModel =
    { title = "listView"
    , items = List.map (\n -> { number = n }) <| List.range 1 100
    , selectedItemNumber = Just 21
    }


view : Model -> Document Never
view model =
    { title = model.title
    , body = List.map (itemView model.selectedItemNumber) model.items
    }


itemView : Maybe Int -> Item -> Html Never
itemView selectedNumber item =
    let
        isSelected =
            Maybe.withDefault False <| Maybe.map ((==) item.number) selectedNumber

        itemNumber =
            String.fromInt item.number
    in
    div
        [ classList [ ( "selected", isSelected ) ]
        ]
        [ a
            [ href <| "/item/" ++ itemNumber
            ]
            [ text "This is item number: "
            , text <| String.fromInt item.number
            ]
        ]
