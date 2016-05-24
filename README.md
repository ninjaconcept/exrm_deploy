# Getting started

Add to your Project dependencies in *mix.exs*:

`{:exrm_deploy, git: "git@github.com:ninjaconcept/exrm_deploy.git"}`

Add deploy task to aliases (*mix.exs*):

`"deploy": "exrm_deploy.deploy"`

Add deployment configuration to *prod.exs*:

```
config :my_app, :deployment,
  server: "deploy.server.tld",
  username: "deploy_user",
  port: 22
```
