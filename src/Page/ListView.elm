module Page.ListView exposing
    ( Model
    , initialModel
    , view
    )

import Html exposing (Html, div, text)
import Html.Attributes exposing (classList)
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


view : Model -> List (Html Never)
view model =
    List.map (itemView model.selectedItemNumber) model.items


itemView : Maybe Int -> Item -> Html Never
itemView selectedNumber item =
    let
        isSelected =
            Maybe.withDefault False <| Maybe.map ((==) item.number) selectedNumber
    in
    div
        [ classList [ ( "selected", isSelected ) ]
        ]
        [ text "This is item number: "
        , text <| String.fromInt item.number
        ]
