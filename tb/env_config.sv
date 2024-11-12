class env_config extends uvm_object;
	`uvm_object_utils(env_config)
	ahb_config ahb_cfg;
	apb_config apb_cfg;
	int no_of_ahbagents = 1;
	int no_of_apbagents = 1;
	function new(string name = "env_config");
		super.new(name);
	endfunction : new
endclass : env_config