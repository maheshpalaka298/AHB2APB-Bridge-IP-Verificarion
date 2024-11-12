interface ahb_if(input bit HCLK);
	logic HRESETn;
	logic [1:0]HTRANS;
	logic HWRITE;
	logic HREADYin;
	logic [31:0]HADDR;
	logic [31:0]HWDATA;
	logic [1:0] HRESP;
	logic [2:0]HSIZE;
	logic [31:0]HRDATA;
	//logic [2:0] HBURST;
	bit HREADYout;
	
	clocking ahb_drv_cb@(posedge HCLK);
		default input #1 output #1;
		output HRESETn;
		output HTRANS;
		output HWRITE;
		output HREADYin;
		output HADDR;
		//output HBURST;
		output HWDATA;
		output HSIZE;
		input HREADYout;
	endclocking : ahb_drv_cb
	clocking ahb_mon_cb@(posedge HCLK);
		default input #1 output #1;
		//input HRESETn;
		input HTRANS;
		input HWRITE;
		input HREADYin;
		input HADDR;
		//input HBURST;
		input HWDATA;
		//input HRESP;
		input HSIZE;
		input HRDATA;
		input HREADYout;
	endclocking : ahb_mon_cb
	modport DRV(clocking ahb_drv_cb);
	modport MON(clocking ahb_mon_cb);
endinterface : ahb_if

interface apb_if(input bit HCLK);
	logic [3:0] PSELx;
	bit PENABLE;
	bit PWRITE;
	logic [31:0]PRDATA;
	logic [31:0]PWDATA;
	logic [31:0]PADDR;
	clocking apb_drv_cb@(posedge HCLK);
		output PRDATA;
		input PSELx;
		input PENABLE;
		input PWRITE;
		//input PWDATA;
		//input PADDR;
	endclocking : apb_drv_cb
	clocking apb_mon_cb@(posedge HCLK);
		input PRDATA;
		input PSELx;
		input PENABLE;
		input PWRITE;
		input PWDATA;
		input PADDR;
	endclocking : apb_mon_cb
	modport DRV(clocking apb_drv_cb);
	modport MON(clocking apb_mon_cb);
endinterface : apb_if