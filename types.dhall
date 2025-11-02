let Size = < Small | Medium | Large >

let Synth
    : Type
    = { name : Text
      , brand : Text
      , price : Natural
      , images : List Text
      , note : Optional Text
      , size : Size
      }

in  { Synth, Size }
