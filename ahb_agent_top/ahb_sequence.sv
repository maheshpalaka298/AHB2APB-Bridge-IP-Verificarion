class ahb_sequence extends uvm_sequence#(ahb_xtn);
	`uvm_object_utils(ahb_sequence)
	function new(string name = "ahb_sequence");
		super.new(name);
	endfunction : new
endclass : ahb_sequence

class single_transfer_seq extends ahb_sequence;
	`uvm_object_utils(single_transfer_seq)
	function new(string name = "single_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HBURST == 0;})
		finish_item(req);
	endtask : body
endclass : single_transfer_seq

class rsingle_transfer_seq extends ahb_sequence;
	`uvm_object_utils(rsingle_transfer_seq)
	function new(string name = "rsingle_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HWRITE == 1'b0; HBURST == 0;})
		finish_item(req);
	endtask : body
endclass : rsingle_transfer_seq

class wsingle_transfer_seq extends ahb_sequence;
	`uvm_object_utils(wsingle_transfer_seq)
	function new(string name = "wsingle_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HWRITE == 1'b1; HBURST == 0;})
		finish_item(req);
	endtask : body
endclass : wsingle_transfer_seq

class INCR_transfer_seq extends ahb_sequence;
	`uvm_object_utils(INCR_transfer_seq)
	bit [31:0] Haddr;
	bit [2:0] Hsize;
	bit [2:0] Hburst;
	bit Hwrite;
	bit [9:0] len;
	function new(string name = "INCR_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HBURST inside {1,3,5,7};}) //HBURST == {1, 3, 5, 7} for INCR
		finish_item(req);
		Haddr = req.HADDR;
		Hsize = req.HSIZE;
		Hwrite = req.HWRITE;
		Hburst = req.HBURST;
		len = req.length;
		for(int i = 1; i < len; i++)
			begin
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite; 
											 HBURST == Hburst;
											 HSIZE == Hsize;
											 HADDR == Haddr + (2 ** Hsize);
											}) 
				finish_item(req);
				Haddr = req.HADDR;
			end
	endtask : body
endclass : INCR_transfer_seq

class rINCR_transfer_seq extends ahb_sequence;
	`uvm_object_utils(rINCR_transfer_seq)
	bit [31:0] Haddr;
	bit [2:0] Hsize;
	bit [2:0] Hburst;
	bit Hwrite;
	bit [9:0] len;
	function new(string name = "rINCR_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HWRITE == 1'b0; HBURST inside {1,3,5,7};}) //HBURST == {1, 3, 5, 7} for INCR
		finish_item(req);
		Haddr = req.HADDR;
		Hsize = req.HSIZE;
		Hwrite = req.HWRITE;
		Hburst = req.HBURST;
		len = req.length;
		for(int i = 1; i < len; i++)
			begin
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite; 
											 HBURST == Hburst;
											 HSIZE == Hsize;
											 HADDR == Haddr + (2 ** Hsize);
											}) 
				finish_item(req);
				Haddr = req.HADDR;
			end
	endtask : body
endclass : rINCR_transfer_seq

class wINCR_transfer_seq extends ahb_sequence;
	`uvm_object_utils(wINCR_transfer_seq)
	bit [31:0] Haddr;
	bit [2:0] Hsize;
	bit [2:0] Hburst;
	bit Hwrite;
	bit [9:0] len;
	function new(string name = "wINCR_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10; HWRITE == 1'b1; HBURST inside {1,3,5,7};}) //HBURST == {1, 3, 5, 7} for INCR
		finish_item(req);
		Haddr = req.HADDR;
		Hsize = req.HSIZE;
		Hwrite = req.HWRITE;
		Hburst = req.HBURST;
		len = req.length;
		for(int i = 1; i < len; i++)
			begin
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite; 
											 HBURST == Hburst;
											 HSIZE == Hsize;
											 HADDR == Haddr + (2 ** Hsize);
											}) 
				finish_item(req);
				Haddr = req.HADDR;
			end
	endtask : body
endclass : wINCR_transfer_seq


class WRAP_transfer_seq extends ahb_sequence;
	`uvm_object_utils(WRAP_transfer_seq)
	bit Hwrite;
	bit [2:0] Hsize;
	bit [31:0] Haddr;
	bit [9:0] len;
	bit [31:0] start_addr;
	bit [31:0] boundary_addr;
	function new(string name = "WRAP_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10;
									 //HWRITE == 1'b1;
									 HBURST inside {2,4,6};
									})
		finish_item(req);
		
		Hwrite = req.HWRITE;
		Hsize = req.HSIZE;
		Haddr = req.HADDR;
		len = req.length;
		
		start_addr = (Haddr / ((2 ** Hsize) * len)) * ((2 ** Hsize) * len);
		boundary_addr = start_addr + ((2 ** Hsize) * len);
		$display("start_addr = %0h", start_addr);
		$display("boundary_addr = %0h", boundary_addr);
		
		Haddr = Haddr + (2**Hsize);
		for(int i = 1; i < len; i++)
			begin
				if(Haddr >= boundary_addr)
					Haddr = start_addr;
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite;
											 HSIZE == Hsize;
											 HADDR == Haddr;
											})
				finish_item(req);
				Haddr = req.HADDR + (2** Hsize);
			end
	endtask : body
endclass : WRAP_transfer_seq

class rWRAP_transfer_seq extends ahb_sequence;
	`uvm_object_utils(rWRAP_transfer_seq)
	bit Hwrite;
	bit [2:0] Hsize;
	bit [31:0] Haddr;
	bit [9:0] len;
	bit [31:0] start_addr;
	bit [31:0] boundary_addr;
	function new(string name = "rWRAP_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10;
									 HWRITE == 1'b0;
									 HBURST inside {2,4,6};
									})
		finish_item(req);
		
		Hwrite = req.HWRITE;
		Hsize = req.HSIZE;
		Haddr = req.HADDR;
		len = req.length;
		
		start_addr = (Haddr / ((2 ** Hsize) * len)) * ((2 ** Hsize) * len);
		boundary_addr = start_addr + ((2 ** Hsize) * len);
		$display("start_addr = %0h", start_addr);
		$display("boundary_addr = %0h", boundary_addr);
		
		Haddr = Haddr + (2**Hsize);
		for(int i = 1; i < len; i++)
			begin
				if(Haddr >= boundary_addr)
					Haddr = start_addr;
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite;
											 HSIZE == Hsize;
											 HADDR == Haddr;
											})
				finish_item(req);
				Haddr = req.HADDR + (2** Hsize);
			end
	endtask : body
endclass : rWRAP_transfer_seq

class wWRAP_transfer_seq extends ahb_sequence;
	`uvm_object_utils(wWRAP_transfer_seq)
	bit Hwrite;
	bit [2:0] Hsize;
	bit [31:0] Haddr;
	bit [9:0] len;
	bit [31:0] start_addr;
	bit [31:0] boundary_addr;
	function new(string name = "wWRAP_transfer_seq");
		super.new(name);
	endfunction : new
	task body();
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS == 2'b10;
									 HWRITE == 1'b1;
									 HBURST inside {2,4,6};
									})
		finish_item(req);
		
		Hwrite = req.HWRITE;
		Hsize = req.HSIZE;
		Haddr = req.HADDR;
		len = req.length;
		
		start_addr = (Haddr / ((2 ** Hsize) * len)) * ((2 ** Hsize) * len);
		boundary_addr = start_addr + ((2 ** Hsize) * len);
		$display("start_addr = %0h", start_addr);
		$display("boundary_addr = %0h", boundary_addr);
		
		Haddr = Haddr + (2**Hsize);
		for(int i = 1; i < len; i++)
			begin
				if(Haddr >= boundary_addr)
					Haddr = start_addr;
				start_item(req);
				assert(req.randomize() with {HTRANS == 2'b11;
											 HWRITE == Hwrite;
											 HSIZE == Hsize;
											 HADDR == Haddr;
											})
				finish_item(req);
				Haddr = req.HADDR + (2** Hsize);
			end
	endtask : body
endclass : wWRAP_transfer_seq