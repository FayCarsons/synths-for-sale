let GHA =
      https://raw.githubusercontent.com/regadas/github-actions-dhall/HEAD/package.dhall

let checkout = GHA.Step::{ uses = Some "actions/checkout@v3" }

let installDhall =
      GHA.Step::{
      , name = Some "Install Dhall"
      , uses = Some "dhall-lang/setup-dhall@v4"
      , `with` = Some (toMap { github_token = "\${{ github.token }}" })
      }

let convertData =
      GHA.Step::{
      , name = Some "Convert Dhall to JSON"
      , run = Some "dhall-to-json --file synths.dhall > site/data/synths.json"
      }

let setupPython =
      GHA.Step::{
      , name = Some "Set up Python3"
      , uses = Some "actions/setup-python@v4"
      , `with` = Some (toMap { python-version = "3.13" })
      }

let setupUV =
      GHA.Step::{
      , name = Some "Set up Python3 + UV"
      , uses = Some "astral-sh/setup-uv@v1"
      }

let generateCheckouts =
      GHA.Step::{
      , name = Some "Generate Stripe checkout links"
      , run = Some
          "cd PaymentLinks && uv sync && uv run main.py ../site/data/synths.json ../site/data/checkout-links.json"
      , env = Some
          (toMap { STRIPE_SECRET_KEY = "\${{ secrets.STRIPE_SECRET_KEY }}" })
      }

let installHugo =
      GHA.Step::{
      , name = Some "Install Hugo"
      , uses = Some "peaceiris/actions-hugo@v2"
      , `with` = Some (toMap { hugo-version = "latest" })
      }

let build = GHA.Step::{ name = Some "Build", run = Some "cd site && hugo" }

let deploy =
      GHA.Step::{
      , name = Some "Deploy"
      , uses = Some "peaceiris/actions-gh-pages@v3"
      , `with` = Some
          ( toMap
              { github_token = "\${{ secrets.GITHUB_TOKEN }}"
              , publish_dir = "./site/docs"
              }
          )
      }

in  GHA.Workflow::{
    , name = "Build and deploy"
    , on = GHA.On::{ push = Some GHA.Push::{ branches = Some [ "main" ] } }
    , jobs = toMap
        { build-and-deploy = GHA.Job::{
          , name = Some "Build and deploy"
          , runs-on = GHA.types.RunsOn.ubuntu-latest
          , steps =
            [ checkout
            , installDhall
            , convertData
            , setupPython
            , setupUV
            , generateCheckouts
            , installHugo
            , build
            , deploy
            ]
          }
        }
    , permissions = Some
      [ { mapKey = GHA.types.Permission.contents
        , mapValue = GHA.types.PermissionAccess.write
        }
      ]
    }
