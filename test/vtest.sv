class single_vtest extends test;
	`uvm_component_utils(single_vtest)
	single_vseq vseq;
	function new(string name = "single_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseq = single_vseq::type_id::create("vseq");
		vseq.start(envh.v_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : single_vtest

class INCR_vtest extends test;
	`uvm_component_utils(INCR_vtest)
	INCR_vseq vseq;
	function new(string name = "INCR_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseq = INCR_vseq::type_id::create("vseq");
		vseq.start(envh.v_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : INCR_vtest

class WRAP_vtest extends test;
	`uvm_component_utils(WRAP_vtest)
	WRAP_vseq vseq;
	function new(string name = "WRAP_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseq = WRAP_vseq::type_id::create("vseq");
		vseq.start(envh.v_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : WRAP_vtest