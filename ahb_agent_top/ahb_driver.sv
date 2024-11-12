class ahb_driver extends uvm_driver#(ahb_xtn);
	`uvm_component_utils(ahb_driver)
	virtual ahb_if.DRV vif;
	ahb_config ahb_cfg;
	function new(string name = "ahb_driver", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
			`uvm_fatal("ahb_driver", "AHB Config getting is failed!!")
		super.build_phase(phase);
		//uvm_top.print_topology();
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		vif = ahb_cfg.vif;
	endfunction : connect_phase
	task run_phase(uvm_phase phase);
		@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.HRESETn <= 1'b0;
		@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.HRESETn <= 1'b1;
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask : run_phase
	
	task send_to_dut(ahb_xtn req);
		`uvm_info("ahb_driver", $sformatf("printing from ahb_driver \n %s", req.sprint()), UVM_LOW)
		wait(vif.ahb_drv_cb.HREADYout == 1) //addr and Control Signals
		vif.ahb_drv_cb.HADDR <= req.HADDR;
		vif.ahb_drv_cb.HTRANS <= req.HTRANS;
		vif.ahb_drv_cb.HSIZE <= req.HSIZE;
		vif.ahb_drv_cb.HWRITE <= req.HWRITE;
		vif.ahb_drv_cb.HREADYin <= 1'b1;
		@(vif.ahb_drv_cb);
		wait(vif.ahb_drv_cb.HREADYout == 1) //Data Driving
		if(vif.ahb_drv_cb.HWRITE)
			vif.ahb_drv_cb.HWDATA <= req.HWDATA;
		else
			vif.ahb_drv_cb.HWDATA <= 32'h0;
		// req.print();
	endtask: send_to_dut
endclass : ahb_driver