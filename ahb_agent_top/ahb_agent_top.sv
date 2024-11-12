class ahb_agent_top extends uvm_env;
	`uvm_component_utils(ahb_agent_top)
	ahb_agent ahb_agt[];
	env_config cfg;
	function new(string name = "ahb_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this, "", "cfg", cfg))
			`uvm_fatal("ahb_agent_top", "ENV Config getting is failed!!")
		super.build_phase(phase);
		ahb_agt = new[cfg.no_of_ahbagents];
		for(int i = 0; i < cfg.no_of_ahbagents; i++)
			begin
				ahb_agt[i] = ahb_agent::type_id::create($sformatf("ahb_agt[%0d]", i), this);
				uvm_config_db#(ahb_config)::set(this, "ahb_agent[%0d]*", "ahb_cfg", cfg.ahb_cfg);
			end
	endfunction : build_phase
endclass : ahb_agent_top