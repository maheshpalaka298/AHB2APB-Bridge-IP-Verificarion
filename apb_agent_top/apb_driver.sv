class apb_driver extends uvm_driver;
	`uvm_component_utils(apb_driver)
	virtual apb_if.DRV vif;
	apb_config apb_cfg;
	bit [31:0]prdata;
	
	function new(string name = "apb_driver", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(apb_config)::get(this, "", "apb_cfg", apb_cfg))
			`uvm_fatal("apb_driver", "apb Config getting is failed!!")
		super.build_phase(phase);
		uvm_top.print_topology();
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		vif = apb_cfg.vif;
	endfunction : connect_phase
	task run_phase(uvm_phase phase);
		forever
			begin
				// seq_item_port.get_next_item(req);
				send_to_dut();
				// seq_item_port.item_done(req);
			end
	endtask : run_phase
	task send_to_dut();
		wait(vif.apb_drv_cb.PSELx != 0)
		if(vif.apb_drv_cb.PWRITE == 0)
			begin	
				wait(vif.apb_drv_cb.PENABLE == 1)
				prdata = $urandom;
				vif.apb_drv_cb.PRDATA <= prdata;
				`uvm_info("apb_driver", $sformatf("printing from apb_driver\n------------------------\nPRDATA       'h%h\n------------------------\n", prdata), UVM_LOW)
			end
		repeat(2)
			@(vif.apb_drv_cb);
	endtask: send_to_dut
endclass : apb_driver
