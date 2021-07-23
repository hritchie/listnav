module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav exposing (Key)
import Html exposing (text)
import Item exposing (Item)
import Page.ItemPage as ItemPage
import Page.ListPage as ListPage
import Url exposing (Url)
import Url.Parser as Url exposing ((</>), (<?>), Parser, s)
import Url.Parser.Query as Query


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


type alias Model =
    { key : Key
    , page : Page
    }


type Page
    = ListPage ListPage.Model
    | ItemPage ItemPage.Model
    | NotFound


type Msg
    = Noop
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Flags =
    ()


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , page = parsePage url
      }
    , Cmd.none
    )


parsePage : Url -> Page
parsePage url =
    Maybe.withDefault NotFound <| Url.parse parseUrl url


view : Model -> Document Msg
view model =
    let
        map : (a -> Msg) -> Document a -> Document Msg
        map msg document =
            { title = document.title
            , body = List.map (Html.map msg) document.body
            }
    in
    case model.page of
        NotFound ->
            { title = "Page Not Found"
            , body = []
            }

        ListPage listPageModel ->
            map (always Noop) <|
                ListPage.view listPageModel

        ItemPage itemPageModel ->
            map (always Noop) <|
                ItemPage.view itemPageModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        OnUrlRequest urlRequest ->
            let
                _ =
                    Debug.log "OnUrlRequest" urlRequest
            in
            case urlRequest of
                Internal url ->
                    ( { model | page = parsePage url }
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        OnUrlChange url ->
            let
                _ =
                    Debug.log "OnUrlChange" url
            in
            ( { model | page = parsePage url }
            , Cmd.none
            )


subscriptions : model -> Sub Msg
subscriptions model =
    Sub.none


parseUrl : Parser (Page -> a) a
parseUrl =
    Url.oneOf
        [ Url.map makeListPage (Url.top <?> Query.string "selected")
        , Url.map makeItemPage (s "item" </> Url.int)
        ]


makeListPage : Maybe String -> Page
makeListPage selectedItem =
    ListPage
        { title = "listView"
        , items = List.map (\n -> { number = n }) <| List.range 1 100
        , selectedItemNumber = Maybe.andThen String.toInt selectedItem
        }


makeItemPage : Int -> Page
makeItemPage itemNumber =
    ItemPage
        { title = "Item Page -- " ++ String.fromInt itemNumber
        , item = Item itemNumber
        }
