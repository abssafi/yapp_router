/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;

// generate 5 random packets and use the print method
// to display the results
// experiment with print method
// experiment with the copy, clone and compare UVM method
yapp_packet p1, p2, p3;
int ok;

initial begin
$display("Generate 5 random packets TEST!");
for(int i = 0; i < 5; i++) begin
   p1 = new("p1");
   ok = p1.randomize();
   p1.print();
end

$display("TABLE TEST!");
p1.print(uvm_default_table_printer);
$display("TREELINE TEST!");
p1.print(uvm_default_tree_printer);
$display("LINE TEST!");
p1.print(uvm_default_line_printer);

$display("COPY TEST!");
p2 = new("p2");
p2.copy(p1);
p2.print();

$display("CLONE TEST!");
p3 = new("p3");
$cast(p3,p1.clone);
p3.print();

$finish;
end

endmodule : top
