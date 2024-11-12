class ahb_monitor extends uvm_monitor;
	`uvm_component_utils(ahb_monitor)
	virtual ahb_if.MON vif;
	ahb_config ahb_cfg;
	uvm_analysis_port#(ahb_xtn) ap;
	ahb_xtn xtn;
	function new(string name = "ahb_monitor", uvm_component parent);
		super.new(name, parent);
		ap = new("ap", this);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
			`uvm_fatal("ahb_monitor", "AHB Config getting is failed!!")
		super.build_phase(phase);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		vif = ahb_cfg.vif;
	endfunction : connect_phase
	task run_phase(uvm_phase phase);
		forever
			begin
				collect_data();
			end
	endtask : run_phase
	task collect_data();
		xtn = ahb_xtn::type_id::create("xtn");
		wait((vif.ahb_mon_cb.HTRANS == 2'b10 || vif.ahb_mon_cb.HTRANS == 2'b11) &&(vif.ahb_mon_cb.HREADYout == 1))
		xtn.HADDR = vif.ahb_mon_cb.HADDR;
		xtn.HTRANS = vif.ahb_mon_cb.HTRANS;
		xtn.HSIZE = vif.ahb_mon_cb.HSIZE;
		xtn.HWRITE = vif.ahb_mon_cb.HWRITE;
		xtn.HREADYin = vif.ahb_mon_cb.HREADYin;
		@(vif.ahb_mon_cb);
		//$display("MONDATA before = %0p, time = %t, hwrite = %0d",xtn.HWDATA,$time,xtn.HWRITE);
		wait(vif.ahb_mon_cb.HREADYout == 1)
		if(vif.ahb_mon_cb.HWRITE == 1)
			xtn.HWDATA = vif.ahb_mon_cb.HWDATA;
		else
			xtn.HRDATA = vif.ahb_mon_cb.HRDATA;
		//$display("MONDATA after = %0p, time = %t ,hwrite = %0d",xtn.HWDATA,$time,xtn.HWRITE);
		`uvm_info("ahb_monitor", $sformatf("printing from monitor \n %s", xtn.sprint()), UVM_LOW)
		ap.write(xtn);
	endtask : collect_data
endclass : ahb_monitor