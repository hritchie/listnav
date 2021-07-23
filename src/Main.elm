module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (text)
import Page.ItemPage as ItemPage
import Page.ListPage as ListPage
import Url exposing (Url)


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
    { page : Page
    }


type Page
    = ListPage ListPage.Model
    | ItemPage ItemPage.Model


type Msg
    = Noop
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Flags =
    ()


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { page = ListPage ListPage.initialModel }
    , Cmd.none
    )


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
            ( model, Cmd.none )

        OnUrlChange url ->
            let
                _ =
                    Debug.log "OnUrlChange" url
            in
            ( model, Cmd.none )


subscriptions : model -> Sub Msg
subscriptions model =
    Sub.none
