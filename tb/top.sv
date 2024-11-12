module top;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import bridge_pkg::*;
	bit HCLK;
	always #5 HCLK = ~HCLK;
	ahb_if if1(HCLK);
	apb_if if2(HCLK);
	
	logic [3:0] PSELx;
	logic PENABLE;
	logic PWRITE;
	logic [31:0]PRDATA;
	logic [31:0]PWDATA;
	logic [31:0]PADDR;
	
	rtl_top DUV(.Hclk(HCLK),
                .Hresetn(if1.HRESETn),
                .Htrans(if1.HTRANS),
				.Hsize(if1.HSIZE), 
				.Hreadyin(if1.HREADYin),
		    	.Hwdata(if1.HWDATA), 
				.Haddr(if1.HADDR),
				.Hwrite(if1.HWRITE),
				.Hrdata(if1.HRDATA),
				.Hresp(if1.HRESP),
				.Hreadyout(if1.HREADYout),
				.Prdata(if2.PRDATA),
				.Pselx(if2.PSELx),
				.Pwrite(if2.PWRITE),
				.Penable(if2.PENABLE), 
				.Paddr(if2.PADDR),
				.Pwdata(if2.PWDATA)
		    );
	initial
		begin
			uvm_config_db#(virtual ahb_if)::set(null, "*", "if1", if1);
			uvm_config_db#(virtual apb_if)::set(null, "*", "if2", if2);
			run_test();
		end
endmodule