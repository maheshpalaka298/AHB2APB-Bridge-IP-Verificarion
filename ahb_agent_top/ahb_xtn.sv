class ahb_xtn extends uvm_sequence_item;
	`uvm_object_utils(ahb_xtn)
	rand bit [31:0] HADDR;
	rand bit [2:0] HSIZE;
	rand bit [2:0] HBURST;
	rand bit [31:0] HWDATA;
	rand bit HWRITE;
	rand bit [1:0] HTRANS;
	bit HRESETn;
	bit HRESP;
	bit HREADYin;
	bit HREADYout;
	bit [31:0] HRDATA;
	rand bit [9:0] length;
	
	constraint VALID_HSIZE{HSIZE inside {[0:2]};}
	
	constraint VALID_HADDR{HADDR inside {[32'h8000_0000 : 32'h8000_03ff],
										 [32'h8400_0000 : 32'h8400_03ff],
										 [32'h8800_0000 : 32'h8800_03ff],
										 [32'h8c00_0000 : 32'h8c00_03ff]};
										}
										
	constraint VALID_LENGTH{HBURST == 3'b000 -> length == 1;
							HBURST == 3'b001 -> (HADDR%1024 + length*(2**HSIZE)) <= 1023;
							HBURST == 3'b010 -> length == 4;
							HBURST == 3'b011 -> length == 4;
							HBURST == 3'b100 -> length == 8;
							HBURST == 3'b101 -> length == 8;
							HBURST == 3'b110 -> length == 16;
							HBURST == 3'b111 -> length == 16;
							}
							
	constraint VALID_HADDRINCR{HSIZE == 2'b01 -> HADDR % 2 == 0;
							   HSIZE == 2'b10 -> HADDR % 4 == 0;
							  }
							  
	function new(string name = "ahb_xtn");
		super.new(name);
	endfunction : new
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("HWRITE",          this.HWRITE,        1,        UVM_DEC);
		printer.print_field("HADDR",           this.HADDR,        32,        UVM_HEX);
		printer.print_field("HWDATA",          this.HWDATA,       32,        UVM_HEX);
		printer.print_field("HBURST",          this.HBURST,        3,        UVM_DEC);
		printer.print_field("HSIZE",           this.HSIZE,         3,        UVM_DEC);
		printer.print_field("HTRANS",          this.HTRANS,        2,        UVM_DEC);
		printer.print_field("HRDATA",          this.HRDATA,       32,        UVM_HEX);
		printer.print_field("Length",          this.length,       10,        UVM_HEX);
		printer.print_field("HREADYout",       this.HREADYout,     1,        UVM_DEC);		
		
	endfunction 
endclass : ahb_xtn