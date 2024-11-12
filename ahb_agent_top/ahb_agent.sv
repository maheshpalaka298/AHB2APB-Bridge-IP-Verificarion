class ahb_agent extends uvm_agent;
	`uvm_component_utils(ahb_agent)
	ahb_config ahb_cfg;
	ahb_sequencer ahb_seqr;
	ahb_driver ahb_drv;
	ahb_monitor ahb_mon;
	function new(string name = "ahb_agent", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
			`uvm_fatal("ahb_agent", "ahb CONFIG getting is failed!!")
		ahb_mon = ahb_monitor::type_id::create("ahb_mon", this);
		if(ahb_cfg.is_active == UVM_ACTIVE)
			begin
				ahb_drv = ahb_driver::type_id::create("ahb_drv", this);
				ahb_seqr = ahb_sequencer::type_id::create("ahb_seqr", this);
			end
		super.build_phase(phase);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		if(ahb_cfg.is_active == UVM_ACTIVE)
			begin
				ahb_drv.seq_item_port.connect(ahb_seqr.seq_item_export);
			end
	endfunction : connect_phase
endclass :  ahb_agent