module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = SelectedEventCategories {isAcademic : Bool, isWork : Bool, isProject : Bool, isAward : Bool}


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected = SelectedEventCategories {isAcademic = True, isWork = True, isProject = True, isAward = True}
    



{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    let
        (SelectedEventCategories {isAcademic, isWork, isProject, isAward}) = current
    in
        case category of
            Academic -> if (isAcademic == True) then True
                       else False
            Work -> if (isWork == True) then True
                    else False
            Project -> if (isProject == True) then True
                       else False
            Award -> if (isAward == True) then True
                     else False
    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    let
        (SelectedEventCategories {isAcademic, isWork, isProject, isAward}) = current
    in
    case category of
       Academic -> SelectedEventCategories {isAcademic = value, isWork = isWork, isProject = isProject, isAward = isAward}
       Work -> SelectedEventCategories {isAcademic = isAcademic, isWork = value, isProject = isProject, isAward = isAward}
       Project -> SelectedEventCategories {isAcademic = isAcademic, isWork = isWork, isProject = value, isAward = isAward}
       Award -> SelectedEventCategories {isAcademic = isAcademic, isWork = isWork, isProject = isProject, isAward = value}
    --Debug.todo "Implement Model.Event.Category.set"


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    div [] 
    [ (checkbox "Academic" (isEventCategorySelected Academic model) Academic)
    , (checkbox "Work" (isEventCategorySelected Work model) Work)
    , (checkbox "Project" (isEventCategorySelected Project model) Project)
    , (checkbox "Award" (isEventCategorySelected Award model) Award) 
    ]
    --Debug.todo "Implement the Model.Event.Category.view function"
