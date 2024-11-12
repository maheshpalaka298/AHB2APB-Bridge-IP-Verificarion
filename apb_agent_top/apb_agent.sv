class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)
	apb_config apb_cfg;
	apb_sequencer apb_seqr;
	apb_driver apb_drv;
	apb_monitor apb_mon;
	function new(string name = "apb_agent", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(apb_config)::get(this, "", "apb_cfg", apb_cfg))
			`uvm_fatal("apb_agent", "APB CONFIG getting is failed!!")
		apb_mon = apb_monitor::type_id::create("apb_mon", this);
		if(apb_cfg.is_active == UVM_ACTIVE)
			begin
				apb_drv = apb_driver::type_id::create("apb_drv", this);
				apb_seqr = apb_sequencer::type_id::create("apb_seqr", this);
			end
		super.build_phase(phase);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		if(apb_cfg.is_active == UVM_ACTIVE)
			begin
				apb_drv.seq_item_port.connect(apb_seqr.seq_item_export);
			end
	endfunction : connect_phase
endclass :  apb_agent