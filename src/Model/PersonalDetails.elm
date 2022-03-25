module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id)
import Html.Attributes exposing (href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
        let
            getContacts ls = 
                    ls
                    |> List.map (\l -> li [class "contact-detail"] [text (l.name ++ " " ++ l.detail)])
            
            getLinks ls =
                    ls
                    |> List.map(\l -> li [class "social-link"] [text (l.name ++ " "), a [href l.detail] [text l.detail]])
        in
        div []
        [ h1 [id "name"][text details.name]
        , em [id "intro"][text details.intro]
        , ul [] (getContacts details.contacts)
        , ul [] (getLinks details.socials) 
        ]
    
