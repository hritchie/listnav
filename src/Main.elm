module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (text)
import Page.ListView as ListView
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
    = ListView ListView.Model


type Msg
    = Noop
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


type alias Flags =
    ()


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { page = ListView ListView.initialModel }
    , Cmd.none
    )


view : Model -> Document Msg
view model =
    case model.page of
        ListView listViewModel ->
            { title = listViewModel.title
            , body =
                List.map (Html.map (always Noop)) <|
                    ListView.view listViewModel
            }


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
