class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard);
	
	ahb_xtn ahb_data;
	apb_xtn apb_data;
	uvm_tlm_analysis_fifo #(ahb_xtn) fifo_ahb;
	uvm_tlm_analysis_fifo #(apb_xtn) fifo_apb;
	
	env_config cfg;
	
	covergroup cg1; 
		HADDR: coverpoint ahb_data.HADDR{bins slave1 = {[32'h8000_0000 : 32'h8000_03ff]};
									         bins slave2 = {[32'h8400_0000 : 32'h8400_03ff]};
									         bins slave3 = {[32'h8800_0000 : 32'h8800_03ff]};
									         bins slave4 = {[32'h8c00_0000 : 32'h8c00_03ff]};
									        }
		HTRANS: coverpoint ahb_data.HTRANS{bins non_seq = {2};
											   bins seq = {3};
											  }
		HWRITE: coverpoint ahb_data.HWRITE{bins w0 = {0};
											   bins w1 = {1};
											}
		HSIZE: coverpoint ahb_data.HSIZE{bins s1 = {0};
											 bins s2 = {1};
											 bins s3 = {2};
											}
		CROSS: cross HADDR,HTRANS,HWRITE,HSIZE;
	endgroup: cg1
	
	covergroup cg2;
		PADDR: coverpoint apb_data.PADDR{bins slave1 = {[32'h8000_0000 : 32'h8000_03ff]};
									bins slave2 = {[32'h8400_0000 : 32'h8400_03ff]};
									bins slave3 = {[32'h8800_0000 : 32'h8800_03ff]};
									bins slave4 = {[32'h8c00_0000 : 32'h8c00_03ff]};		
									}
	
		PSELX: coverpoint apb_data.PSELx{bins selx1 = {1};
									bins selx2 = {2};
									bins selx3 = {4};
									bins selx4 = {8};
									}
		CROSS2: cross PADDR, PSELX;
	endgroup: cg2		
	
	function new(string name = "scoreboard", uvm_component parent);
		super.new(name, parent);
		cg1 = new();
		cg2 = new();
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this,"","cfg",cfg))
			`uvm_fatal("Config","in SB getting failed")
		fifo_ahb = new("fifo_ahb",this);
		fifo_apb = new("fifo_apb",this);
		super.build_phase(phase);
	endfunction : build_phase
	
	task run_phase(uvm_phase phase);
		forever 
			begin
				fork
					begin	
						fifo_ahb.get(ahb_data);
							`uvm_info("SB","AHB_data",UVM_LOW)
						ahb_data.print;
						cg1.sample();
					end
					begin	
						fifo_apb.get(apb_data);
							`uvm_info("SB","APB_Data",UVM_LOW)
						apb_data.print;
						cg2.sample();
					end
				join
				check_data(ahb_data,apb_data);
			end
	endtask: run_phase
	
	task check_data(ahb_xtn ahb, apb_xtn apb);
		if(ahb.HWRITE == 1'b1)
			begin
				if(ahb.HSIZE == 2'b00)
					begin
						if(ahb.HADDR[1:0] == 2'b00)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[7:0],apb.PWDATA);
						if(ahb.HADDR[1:0] == 2'b01)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[15:8],apb.PWDATA);
						if(ahb.HADDR[1:0] == 2'b10)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[23:16],apb.PWDATA);
						if(ahb.HADDR[1:0] == 2'b11)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[31:24],apb.PWDATA);
					end
				if(ahb.HSIZE ==	2'b01)
					begin
						if(ahb.HADDR[1:0] == 2'b00)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[15:0],apb.PWDATA);
						if(ahb.HADDR[1:0] == 2'b10)
							compare(ahb.HADDR,apb.PADDR,ahb.HWDATA[31:16],apb.PWDATA);
					end
				if(ahb.HSIZE ==	2'b10)
					compare(ahb.HADDR,apb.PADDR,ahb.HWDATA,apb.PWDATA);
			end
		if(ahb.HWRITE == 1'b0)
			begin
				if(ahb.HSIZE == 2'b00)
					begin
						if(ahb.HADDR[1:0]== 2'b00)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[7:0]);
						if(ahb.HADDR[1:0]== 2'b01)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[15:8]);
						if(ahb.HADDR[1:0]== 2'b10)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[23:16]);
						if(ahb.HADDR[1:0]== 2'b11)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[31:24]);
					end
				if(ahb.HSIZE == 2'b01)
					begin
						if(ahb.HADDR[1:0] == 2'b00)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[15:0]);
						if(ahb.HADDR[1:0] == 2'b10)
							compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA[31:16]);
					end
				if(ahb.HSIZE == 2'b10)
					compare(ahb.HADDR,apb.PADDR,ahb.HRDATA,apb.PRDATA);
			end
						
	endtask: check_data
	
	task compare(int Haddr,Paddr,Hdata,Pdata);
		if(Haddr == Paddr)
			`uvm_info("scoreboard","ADDR Comparison Success",UVM_LOW)
		else
			`uvm_error("scoreboard","ADDR Comparison Failed")
		if(Hdata == Pdata)
			`uvm_info("scoreboard","Data Comparison Success",UVM_LOW)
		else
			`uvm_error("scoreboard","Data Comparison Failed")
	endtask: compare
endclass : scoreboard