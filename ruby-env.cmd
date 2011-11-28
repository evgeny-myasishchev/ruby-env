@echo off

call clear-ruby-env.cmd
call local-env.cmd

set ARGS=%1
FOR /F "delims=@ tokens=1,2" %%i in ("%1") do (
    set RUBY=%%i
    set GEMSET_NAME=%%j
)

if NOT DEFINED RUBY (
    echo Please provide ruby specification as a first argument. 
    echo It must be in form: ruby-name@[gemset-name]. Sample 1.8.7@test1
    echo * gemset-name is optional. If ommited then "default" is implied.
    exit /b 1
)

if NOT DEFINED GEMSET_NAME (
    set GEMSET_NAME=default
)

set RUBY_HOME=%RUBIES_HOME%\%RUBY%

if NOT EXIST %RUBY_HOME%\bin\ruby.exe (
    echo %RUBY_HOME%\bin\ruby.exe does not exist. 
    echo Please make sure ruby is installed at path: %RUBY_HOME%\
    exit /b 1
)

set PATH_WITHOUT_RUBY_ENV=%PATH%
set GEM_HOME=%RUBY_HOME%-%GEMSET_NAME%
set GEM_PATH=%RUBY_HOME%-%GEMSET_NAME%
set PATH=%RUBY_HOME%\bin;%GEM_HOME%\bin;%PATH%
