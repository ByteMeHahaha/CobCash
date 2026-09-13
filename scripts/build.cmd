@REM Command Prompt compile script
@REM First run "set_env.cmd" from GnuCOBOL's root folder

@REM Build in the binary folder
cobc -I ../src/copy ^
  -x ../src/main.cbl ^
  -o ../bin/CobCash ^
  -w -q

@REM Note: Run from the "scripts" folder
