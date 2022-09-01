@echo off
set xv_path=C:\\Xilinx\\SDx\\2017.1\\Vivado\\bin
call %xv_path%/xsim test_TOP_behav -key {Behavioral:sim_1:Functional:test_TOP} -tclbatch test_TOP.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
