@echo off
set xv_path=C:\\Xilinx\\SDx\\2017.1\\Vivado\\bin
call %xv_path%/xelab  -wto 177fd7f0df7748609bd2a872e574eff2 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot test_CLA_behav xil_defaultlib.test_CLA xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
