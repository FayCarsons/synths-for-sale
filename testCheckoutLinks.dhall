let types = ./types.dhall

let synths = ./synths.dhall

let LinkMap
    : Type
    = List { mapKey : Text, mapValue : Text }

let makeLink =
      \(synth : types.Synth) ->
      \(acc : LinkMap) ->
        acc # [ { mapKey = synth.name, mapValue = "fake.com" } ]

in  List/fold types.Synth synths LinkMap makeLink ([] : LinkMap)
