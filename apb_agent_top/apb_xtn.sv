class apb_xtn extends uvm_sequence_item;
	`uvm_object_utils(apb_xtn)
	bit [31:0] PADDR;
	bit [31:0] PWDATA;
	rand bit [31:0] PRDATA;
	bit PWRITE;
	bit PENABLE;
	bit [3:0]PSELx;
	
	function new(string name = "apb_xtn");
		super.new(name);
	endfunction : new
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("PWRITE",       this.PWRITE,       1,        UVM_DEC);
		printer.print_field("PENABLE",      this.PENABLE,      1,        UVM_DEC);
		printer.print_field("PSELx",        this.PSELx,        4,        UVM_BIN);
		printer.print_field("PADDR",        this.PADDR,        32,       UVM_HEX);
		printer.print_field("PWDATA",       this.PWDATA,       32,       UVM_HEX);
		printer.print_field("PRDATA",       this.PRDATA,       32,       UVM_HEX);
	endfunction: do_print
endclass : apb_xtn