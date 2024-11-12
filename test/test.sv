class test extends uvm_test;
	`uvm_component_utils(test)
	env_config cfg;
	apb_config apb_cfg;
	ahb_config ahb_cfg;
	env envh;
	function new(string name = "test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		ahb_cfg = ahb_config::type_id::create("ahb_cfg");
		if(!uvm_config_db#(virtual ahb_if)::get(this, "", "if1", ahb_cfg.vif))
			`uvm_fatal("test", "AHB Virtual interface getting is failed!!")
		apb_cfg = apb_config::type_id::create("apb_cfg");
		if(!uvm_config_db#(virtual apb_if)::get(this, "", "if2", apb_cfg.vif))
			`uvm_fatal("test", "APB Virtual interface getting is failed!!")
		cfg = env_config::type_id::create("cfg");
		cfg.ahb_cfg = ahb_cfg;
		cfg.apb_cfg = apb_cfg;
		cfg.no_of_ahbagents = 1;
		cfg.no_of_apbagents = 1;
		uvm_config_db#(env_config)::set(this, "*", "cfg", cfg);
		envh = env::type_id::create("envh", this);
		super.build_phase(phase);
	endfunction : build_phase
endclass : test

class single_transfer_test extends test;
	`uvm_component_utils(single_transfer_test)
	single_transfer_seq seq;
	function new(string name = "single_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		seq = single_transfer_seq::type_id::create("seq");
		phase.raise_objection(this);
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : single_transfer_test

class rsingle_transfer_test extends test;
	`uvm_component_utils(rsingle_transfer_test)
	rsingle_transfer_seq seq;
	function new(string name = "rsingle_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = rsingle_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : rsingle_transfer_test

class wsingle_transfer_test extends test;
	`uvm_component_utils(wsingle_transfer_test)
	wsingle_transfer_seq seq;
	function new(string name = "wsingle_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = wsingle_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : wsingle_transfer_test

class INCR_transfer_test extends test;
	`uvm_component_utils(INCR_transfer_test)
	INCR_transfer_seq seq;
	function new(string name = "INCR_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		seq = INCR_transfer_seq::type_id::create("seq");
		phase.raise_objection(this);
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : INCR_transfer_test

class rINCR_transfer_test extends test;
	`uvm_component_utils(rINCR_transfer_test)
	rINCR_transfer_seq seq;
	function new(string name = "rINCR_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = rINCR_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : rINCR_transfer_test

class wINCR_transfer_test extends test;
	`uvm_component_utils(wINCR_transfer_test)
	wINCR_transfer_seq seq;
	function new(string name = "wINCR_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = wINCR_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : wINCR_transfer_test

class WRAP_transfer_test extends test;
	`uvm_component_utils(WRAP_transfer_test)
	WRAP_transfer_seq seq;
	function new(string name = "WRAP_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		seq = WRAP_transfer_seq::type_id::create("seq");
		phase.raise_objection(this);
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : WRAP_transfer_test

class rWRAP_transfer_test extends test;
	`uvm_component_utils(rWRAP_transfer_test)
	rWRAP_transfer_seq seq;
	function new(string name = "rWRAP_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = rWRAP_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : rWRAP_transfer_test

class wWRAP_transfer_test extends test;
	`uvm_component_utils(wWRAP_transfer_test)
	wWRAP_transfer_seq seq;
	function new(string name = "wWRAP_transfer_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq = wWRAP_transfer_seq::type_id::create("seq");
		seq.start(envh.ahb_agnt.ahb_agt[0].ahb_seqr);
		#41;
		phase.drop_objection(this);
	endtask : run_phase
endclass : wWRAP_transfer_test

