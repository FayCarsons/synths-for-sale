let types = ./types.dhall

let Size
    : Type
    = types.Size

let show =
      \(s : Size) ->
        merge { Small = "Small", Medium = "Medium", Large = "Large" } s

in  [ { mapKey = show Size.Small, mapValue = None Natural }
    , { mapKey = show Size.Medium, mapValue = Some 10 }
    , { mapKey = show Size.Large, mapValue = Some 30 }
    ]
