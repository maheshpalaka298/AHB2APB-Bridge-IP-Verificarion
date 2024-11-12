class apb_agent_top extends uvm_env;
	`uvm_component_utils(apb_agent_top)
	apb_agent apb_agt[];
	env_config cfg;
	function new(string name = "apb_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this, "", "cfg", cfg))
			`uvm_fatal("apb_agent_top", "ENV Config getting is failed!!")
		super.build_phase(phase);
		apb_agt = new[cfg.no_of_apbagents];
		for(int i = 0; i < cfg.no_of_apbagents; i++)
			begin
				apb_agt[i] = apb_agent::type_id::create($sformatf("apb_agt[%0d]", i), this);
				uvm_config_db#(apb_config)::set(this, $sformatf("apb_agt[%0d]*", i), "apb_cfg", cfg.apb_cfg);
			end
	endfunction : build_phase
endclass : apb_agent_top