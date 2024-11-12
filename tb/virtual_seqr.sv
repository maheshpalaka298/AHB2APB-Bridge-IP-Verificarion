class virtual_seqr extends uvm_sequencer;
	`uvm_component_utils(virtual_seqr);
	ahb_sequencer ahb_seqr[];
	apb_sequencer apb_seqr[];
	env_config cfg;
	function new(string name = "virtual_seqr", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this, "", "cfg", cfg))
			`uvm_fatal("virtual_seqr", "ENV Config getting is failed!!")
		ahb_seqr = new[cfg.no_of_ahbagents];
		apb_seqr = new[cfg.no_of_apbagents];
		super.build_phase(phase);
	endfunction : build_phase
endclass : virtual_seqr