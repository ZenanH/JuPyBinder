# JuPyBinder 

Binder for Julia and Python 

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ZenanH/JuPyBinder/main?urlpath=lab)

## Environment

* Julia Language (v1.9.4)
* Python

## Configration 

* `Project.toml`

   > A `Project.toml` file can specify both the version of Julia to be used and a list of Julia packages to be installed. If a `Manifest.toml` is present, it will determine the exact versions of the Julia packages that are installed.

* `environment.yml`

   > `environment.yml` is the standard configuration file used by `conda` that lets you install any kind of package, including `Python` , `R` , and `C/C++` packages. repo2docker does not use your `environment.yml` to create and activate a new conda environment. Rather, it updates a base conda environment defined here with the packages listed in your `environment.yml` . This means that the environment will always have the same default name, not the name specified in your `environment.yml` .
