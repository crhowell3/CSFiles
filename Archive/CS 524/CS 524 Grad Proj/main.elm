view : Model -> Html Msg
view model =
  div []
    [button [ onClick Decrement] [ text "-"]
    , div [] [ text (String.fromInt model)]
    , button [ onClick Increment] [ text "+" ]
    ]

cameron =
  { first = "Cameron"
  , last = "Howell"
  , age = 19
  }
  
