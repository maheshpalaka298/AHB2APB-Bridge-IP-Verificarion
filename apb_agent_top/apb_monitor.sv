class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)
	virtual apb_if.MON vif;
	apb_config apb_cfg;
	uvm_analysis_port#(apb_xtn) ap;
	apb_xtn xtn;
	function new(string name = "apb_monitor", uvm_component parent);
		super.new(name, parent);
		ap = new("ap", this);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(apb_config)::get(this, "", "apb_cfg", apb_cfg))
			`uvm_fatal("apb_monitor", "apb Config getting is failed!!")
		super.build_phase(phase);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		vif = apb_cfg.vif;
	endfunction : connect_phase
	
	task run_phase(uvm_phase phase);
		forever
			begin
				collect_data();
			end
	endtask : run_phase
	
	task collect_data();
		xtn = apb_xtn::type_id::create("xtn");
		wait(vif.apb_mon_cb.PENABLE == 1)
		xtn.PADDR = vif.apb_mon_cb.PADDR;
		xtn.PWRITE = vif.apb_mon_cb.PWRITE;
		xtn.PSELx = vif.apb_mon_cb.PSELx;
		xtn.PENABLE = vif.apb_mon_cb.PENABLE;
		if(xtn.PWRITE == 1)
			xtn.PWDATA = vif.apb_mon_cb.PWDATA;
		else
			xtn.PRDATA = vif.apb_mon_cb.PRDATA;
		//$display("MONDATA after = %0p, time = %t ,hwrite = %0d",xtn.HWDATA,$time,xtn.HWRITE);
		`uvm_info("apb_monitor", $sformatf("printing from apb monitor \n %s", xtn.sprint()), UVM_LOW)
		ap.write(xtn);
		repeat(2)
			@(vif.apb_mon_cb);
	endtask : collect_data
endclass : apb_monitor