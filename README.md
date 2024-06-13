# schieved

Mobile to do list app project
single-handedly developed by locio raihan.

## Getting Started

This project is a starting point for a Flutter application.

--- GETX CLI COMMAND BELOW --- 

// To create a page:
// (Pages have controller, view, and binding)
// Note: you can use any name, ex: `get create page:login`
// Nota: use this option if the chosen structure was Getx_pattern
get create page:home


// To create a new controller in a specific folder:
// Note: you don't need to reference the folder,
// Getx will search automatically for the home folder
// and add your controller there.
get create controller:dialogcontroller on home

// To create a new view in a specific folder:
// Note: you don't need to reference the folder,
// Getx will automatically search for the home folder
// and insert your view there.
get create view:dialogview on home

// To create a new provider in a specific folder:
get create provider:user on home

// To generate a localization file:
// Note: 'assets/locales' directory with your translation files in json format
get generate locales assets/locales

// To generate a class model:
// Note: 'assets/models/user.json' path of your template file in json format
// Note: on  == folder output file
// Getx will automatically search for the home folder
// and insert your class model there.
get generate model on data/models with assets/models/user.json

//to generate the model without the provider
get generate model on data/models with assets/models/user_master.json --skipProvider

//Note: the URL must return a json format
get generate model on home from "https://api.github.com/users/CpdnCristiano"

// To install a package in your project (dependencies):
get install camera

// To install several packages from your project:
get install http path camera

// To install a package with specific version:
get install path:1.6.4

// You can also specify several packages with version numbers

// To install a dev package in your project (dependencies_dev):
get install flutter_launcher_icons --dev

// To remove a package from your project:
get remove http

// To remove several packages from your project:
get remove http path

// To update CLI:
get update
// or `get upgrade`

// Shows the current CLI version:
get -v
// or `get -version`

// For help
get help