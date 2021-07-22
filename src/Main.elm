module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (text)
import Url exposing (Url)


type alias Flags =
    ()


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
    { page : String
    }


type Msg
    = Noop
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { page = "home" }
    , Cmd.none
    )


view : Model -> Document Msg
view model =
    { title = model.page
    , body =
        [ Html.div
            []
            [ text "page : "
            , text model.page
            ]
        ]
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
