@echo off
rem
rem Copyright 2001-2004 The Apache Software Foundation.
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem      http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem

rem -----------------------------------------------------------------------------
rem Maven Start Up Batch script
rem
rem Required ENV vars:
rem ------------------
rem   JAVA_HOME - location of a JRE/JDK
rem
rem Optional ENV vars
rem -----------------
rem   MAVEN_OPTS - parameters passed to the Java VM when running Maven
rem     e.g. to debug Maven itself, use
rem       set MAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
rem   MAVEN_SKIP_RC - flag to disable loading of mavenrc files
rem -----------------------------------------------------------------------------

setlocal

rem Begin all one-time setup

if not "%JAVA_HOME%" == "" (
  set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
) else (
  set "JAVA_CMD=java.exe"
)

if not exist "%JAVA_CMD%" (
  echo Error: JAVA_HOME is not defined, and java.exe is not in your PATH. >&2
  goto:eof
)

rem We're using a semi-private API, so we need to add the --add-opens options
rem to the command line
for /f "tokens=2 delims=." %%a in ('"%JAVA_CMD%" -version 2^>^&1 ^| findstr "version"') do set "version=%%a"
if %version% GEQ 9 (
  set "MAVEN_OPTS=--add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED %MAVEN_OPTS%"
)

rem End all one-time setup

rem Find the project base dir, i.e. the directory that contains the ".mvn" folder.
set MAVEN_BASEDIR=%~dp0
:find-project-dir
if exist "%MAVEN_BASEDIR%.mvn" (
  goto :project-dir-found
)
cd ..
set MAVEN_BASEDIR=%CD%
if "%MAVEN_BASEDIR%"=="%~dps0" (
  echo Could not find the project base directory, i.e. the directory containing the ".mvn" folder.
  goto :eof
)
goto :find-project-dir
:project-dir-found

set MAVEN_PROJECT_BUILD_DIR=%MAVEN_BASEDIR%\target

rem Set the project classpath
if exist "%MAVEN_PROJECT_BUILD_DIR%\maven-classpath.txt" (
  set /p CLASSWORLDS_JAR=<"%MAVEN_PROJECT_BUILD_DIR%\maven-classpath.txt"
) else (
  rem We need to use the wrapper for this
  set "CLASSWORLDS_JAR=%MAVEN_BASEDIR%\.mvn\wrapper\maven-wrapper.jar"
)

rem Set the maven launcher
set MAVEN_LAUNCHER_JAR=%MAVEN_BASEDIR%\.mvn\wrapper\maven-wrapper.jar

"%JAVA_CMD%" %MAVEN_OPTS% -classpath "%MAVEN_LAUNCHER_JAR%" "-Dmaven.home=%MAVEN_BASEDIR%" "-Dmaven.base.dir=%MAVEN_BASEDIR%" org.apache.maven.wrapper.MavenWrapperMain %* 