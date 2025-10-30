let Synth
    : Type
    = { name : Text
      , brand : Text
      , price : Natural
      , images : List Text
      , note : Optional Text
      }

in  [ { name = "Angle Grinder"
      , brand = "Schlappi Engineering"
      , price = 250
      , images = [ "angle-grinder.png" ]
      , note = None Text
      }
    , { name = "Disting Ex"
      , brand = "Expert Sleepers"
      , price = 300
      , images = [ "disting1.png" ]
      , note = None Text
      }
    , { name = "Disting Ex (damaged screen)"
      , brand = "Expert Sleepers"
      , price = 200
      , images = [ "disting-broken-screen1.png", "disting-broken-screen2.png" ]
      , note = Some
          "This distings screen has a bunch of dead pixels(?) I think. Should be a relatively easy fix for the right person."
      }
    , { name = "MIDI breakout"
      , brand = "Expert Sleepers"
      , price = 30
      , images = [] : List Text
      , note = Some "\$15 if bundled with a disting"
      }
    , { name = "Ciao"
      , brand = "Bastl"
      , price = 75
      , images = [ "ciao.png" ]
      , note = None Text
      }
    , { name = "Rnd Step"
      , brand = "DivKid && Steady State Fate"
      , price = 250
      , images = [ "rnd-step.png" ]
      , note = None Text
      }
    , { name = "Plaits"
      , brand = "ALA Audio?"
      , price = 75
      , images = [ "plaits.png" ]
      , note = Some
          "I think this is ALA audio, idk. A plaits clone. V1. Works as expected."
      }
    , { name = "Powered Skiff"
      , brand = "Make Noise"
      , price = 200
      , images = [ "make-noise-powered-skiff.png" ]
      , note = Some "104hp"
      }
    , { name = "Digitone"
      , brand = "Elektron"
      , price = 400
      , images = [ "digitone.png" ]
      , note = None Text
      }
    ]
