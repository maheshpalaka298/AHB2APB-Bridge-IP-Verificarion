class env extends uvm_env;
	`uvm_component_utils(env)
	env_config cfg;
	
	apb_agent_top apb_agnt;
	ahb_agent_top ahb_agnt;
	scoreboard sb;
	virtual_seqr v_seqr;
	function new(string name = "env", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this, "", "cfg", cfg))
			`uvm_fatal("env", "ENV Config getting is failed!!")
		ahb_agnt = ahb_agent_top::type_id::create("ahb_agnt", this);
		uvm_config_db#(ahb_config)::set(this, "ahb_agnt*", "ahb_cfg", cfg.ahb_cfg);
		apb_agnt = apb_agent_top::type_id::create("apb_agnt", this);
		uvm_config_db#(apb_config)::set(this, "apb_agnt*", "apb_cfg", cfg.apb_cfg);
		sb = scoreboard::type_id::create("sb", this);
		v_seqr = virtual_seqr::type_id::create("v_seqr", this);
		super.build_phase(phase);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		for(int i = 0;i < cfg.no_of_ahbagents; i++)
			v_seqr.ahb_seqr[i] = ahb_agnt.ahb_agt[i].ahb_seqr;
		for(int i = 0;i < cfg.no_of_apbagents; i++)
			v_seqr.apb_seqr[i] = apb_agnt.apb_agt[i].apb_seqr;
		for(int i=0;i<cfg.no_of_ahbagents;i++) 
			begin
     		    ahb_agnt.ahb_agt[i].ahb_mon.ap.connect(sb.fifo_ahb.analysis_export);
   			end
		for(int i=0;i<cfg.no_of_apbagents;i++)
			begin
      			apb_agnt.apb_agt[i].apb_mon.ap.connect(sb.fifo_apb.analysis_export);
			end
	endfunction : connect_phase
endclass : env