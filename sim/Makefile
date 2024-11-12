#Makefile for UVM Testbench
RTL= ../Bridge_rtl/* +define+WRAPPING_INCR
RTL1=../Bridge_rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../ahb_agent_top +incdir+../apb_agent_top
SVTB2 = ../test/bridge_pkg.sv
#COVOP= -coveropt 3 +cover=bcsf
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"
VSIMBATCH10= -c -do  " log -r /* ;coverage save -onexit mem_cov9;run -all; exit"

help:
	@echo ====================================================================================================================
	@echo "! USAGE          --  make target                                                                              !"
	@echo "! clean          =>  clean the earlier log and intermediate files.                                            !"
	@echo "! sv_cmp         =>  create library and compile the code.                                                     !"
	@echo "! run_sim        =>  run the simulation in batch mode.                                                        !"
	@echo "! run_test       =>  clean, compile & run the simulation for test in batch mode.                              !"
	@echo "! run_test1      =>  clean, compile & run the simulation for single_transfer_test in batch mode.              !"
	@echo "! run_test2      =>  clean, compile & run the simulation for INCR_transfer_test in batch mode.                !"
	@echo "! run_test3      =>  clean, compile & run the simulation for WRAP_transfer_test in batch mode.                !"
	@echo "! run_test4      =>  clean, compile & run the simulation for rsingle_transfer_test in batch mode.             !"
	@echo "! run_test5      =>  clean, compile & run the simulation for wsingle_transfer_test in batch mode.             !"
	@echo "! run_test6      =>  clean, compile & run the simulation for rINCR_transfer_test in batch mode.               !"
	@echo "! run_test7      =>  clean, compile & run the simulation for wINCR_transfer_test in batch mode.               !"
	@echo "! run_test8      =>  clean, compile & run the simulation for rWRAP_transfer_test in batch mode.               !"
	@echo "! run_test9      =>  clean, compile & run the simulation for wWRAP_transfer_test in batch mode.               !"
 
	@echo "! view_wave      =>  To view the waveform of test                                                             !"
	@echo "! view_wave1     =>  To view the waveform of single_transfer_test                                             !"
	@echo "! view_wave2     =>  To view the waveform of INCR_transfer_test                                               !"
	@echo "! view_wave3     =>  To view the waveform of WRAP_transfer_test                                               !"
	@echo "! view_wave4     =>  To view the waveform of rsingle_transfer_test                                            !"
	@echo "! view_wave5     =>  To view the waveform of wsingle_transfer_test                                            !"
	@echo "! view_wave6     =>  To view the waveform of rINCR_transfer_test                                              !"
	@echo "! view_wave7     =>  To view the waveform of wINCR_transfer_test                                              !"
	@echo "! view_wave8     =>  To view the waveform of rWRAP_transfer_test                                              !"
	@echo "! view_wave9     =>  To view the waveform of wWRAP_transfer_test                                              !"
	@echo "! regress        =>  clean, compile and run all testcases in batch mode.                                      !"
	@echo "! report         =>  To merge coverage reports for all testcases and  convert to html format.                 !"
	@echo "! cov            =>  To open merged coverage report in html format.                                           !"
	@echo ====================================================================================================================


sv_cmp:
	 vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(COVOP) $(RTL) $(INC) $(SVTB2) $(SVTB1)

sv_cmp1:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(COVOP) $(RTL1) $(INC) $(SVTB2) $(SVTB1)

run_test:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1) -wlf wave_file.wlf -l test.log  -sv_seed random  work.top +UVM_TESTNAME=test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov


run_test1:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2) -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=single_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test2:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3) -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=INCR_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test3:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4) -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=WRAP_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3
 
run_test4:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5) -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=rsingle_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4
 
run_test5:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6) -wlf wave_file5.wlf -l test5.log  -sv_seed random  work.top +UVM_TESTNAME=wsingle_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5
 
run_test6:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7) -wlf wave_file6.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=rINCR_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test7:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8) -wlf wave_file7.wlf -l test7.log  -sv_seed random  work.top +UVM_TESTNAME=wINCR_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7
 
run_test8:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9) -wlf wave_file8.wlf -l test8.log  -sv_seed random  work.top +UVM_TESTNAME=rWRAP_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8
 
run_test9:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10) -wlf wave_file9.wlf -l test9.log  -sv_seed random  work.top +UVM_TESTNAME=wWRAP_transfer_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

view_wave:
	vsim -view wave_file.wlf

view_wave1:
	vsim -view wave_file1.wlf

view_wave2:
	vsim -view wave_file2.wlf

view_wave3:
	vsim -view wave_file3.wlf

view_wave4:
	vsim -view wave_file4.wlf

view_wave5:
	vsim -view wave_file5.wlf

view_wave6:
	vsim -view wave_file6.wlf

view_wave7:
	vsim -view wave_file7.wlf
 
view_wave8:
	vsim -view wave_file8.wlf
 
view_wave9:
	vsim -view wave_file9.wlf

report:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress: clean run_test run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 run_test9 report cov

cov:
	firefox covhtmlreport/index.html&

clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

