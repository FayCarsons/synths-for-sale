let types = ./types.dhall

let Size = types.Size

in    [ { name = "Angle Grinder"
        , brand = "Schlappi Engineering"
        , price = 250
        , images = [ "coming-soon.jpg" ]
        , note = None Text
        , size = Size.Medium
        }
      , { name = "Ochd"
        , brand = "DivKid + Instruo"
        , price = 150
        , images = [ "ochd.png" ]
        , note = None Text
        , size = Size.Medium
        }
      , { name = "Stages"
        , brand = "Mutable Instruments (clone?)"
        , price = 250
        , images = [ "stages.png" ]
        , note = Some
            "IIRC this is actually a clone with an MI panel. Can double check if u care"
        , size = Size.Medium
        }
      , { name = "Disting Ex"
        , brand = "Expert Sleepers"
        , price = 300
        , images = [ "disting.png" ]
        , note = None Text
        , size = Size.Medium
        }
      , { name = "Disting Ex (dead pixels)"
        , brand = "Expert Sleepers"
        , price = 200
        , images = [ "coming-soon.jpg" ]
        , note = Some
            "This distings screen has a bunch of dead pixels(?) I think. Should be a relatively easy fix for the right person."
        , size = Size.Medium
        }
      , { name = "MIDI breakout"
        , brand = "Expert Sleepers"
        , price = 30
        , images = [] : List Text
        , note = Some "or free w/ Disting"
        , size = Size.Small
        }
      , { name = "Ciao"
        , brand = "Bastl"
        , price = 75
        , images = [ "coming-soon.jpg" ]
        , note = None Text
        , size = Size.Medium
        }
      , { name = "Rnd Step"
        , brand = "DivKid + Steady State Fate"
        , price = 250
        , images = [ "rnd-step.png" ]
        , note = None Text
        , size = Size.Medium
        }
      , { name = "Plaits"
        , brand = "ALA Audio?"
        , price = 75
        , images = [ "plaits1.png", "/plaits.png" ]
        , note = Some "Plaits clone, ALA audio I think? V1 firmware"
        , size = Size.Medium
        }
      , { name = "Powered Skiff"
        , brand = "Make Noise"
        , price = 200
        , images = [ "coming-soon.jpg" ]
        , note = Some "104hp"
        , size = Size.Large
        }
      , { name = "Digitone"
        , brand = "Elektron"
        , price = 400
        , images = [ "coming-soon.jpg" ]
        , note = None Text
        , size = Size.Large
        }
      ]
    : List types.Synth
