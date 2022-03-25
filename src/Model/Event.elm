module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith (\x1 x2 -> Interval.compare x1.interval x2.interval) events
    --Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
    let     
        getTags strings =
            strings
            |> List.map(\l -> li [] [text l])
        
        isImportant imp =
            if (imp == True) then
                "event event-important"
            else
                "event"
    in 
    div [class (isImportant event.important)] 
    [ h1 [class "event-title"] [text event.title]
    , p [class "event-description"] [event.description]
    , p [class "event-category"] [categoryView event.category]
    , p [class "event-url"] [text (Maybe.withDefault "Nothing" event.url)]
    , p [class "event-interval"] [Interval.view event.interval]
    , ul [] (getTags event.tags)
    ]
    
