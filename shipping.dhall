let types = ./types.dhall

let Small = types.Size.Small

let Medium = types.Size.Medium

let Large = types.Size.Large

in  toMap { Small = "free", Medium = "\$10", Large = "\$30" }
