class apb_sequence extends uvm_sequence;
	`uvm_object_utils(apb_sequence)
	function new(string name = "apb_sequence");
		super.new(name);
	endfunction : new
endclass : apb_sequence

class single_transfer_seq1 extends apb_sequence;
	`uvm_object_utils(single_transfer_seq1)
	function new(string name = "single_transfer_seq1");
		super.new(name);
	endfunction : new
	task body();
		req = apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize())
		finish_item(req);
	endtask : body
endclass : single_transfer_seq1