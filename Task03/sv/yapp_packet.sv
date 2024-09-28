/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit {GOOD_PARITY, BAD_PARITY} parity_type_e;
class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data
  rand bit [1:0] addr;
  rand bit [5:0] length;
  rand bit [7:0] payload[];
  bit [7:0] parity;
  
  rand parity_type_e parity_type;
  rand int packet_delay;
  
  // Define control knobs
  `uvm_object_utils_begin(yapp_packet)
   `uvm_field_int(addr, UVM_ALL_ON)
   `uvm_field_int(length, UVM_ALL_ON)
   `uvm_field_array_int(payload, UVM_ALL_ON)
   `uvm_field_int(parity, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // Enable automation of the packet's fields
  
  // Define packet constraints
   constraint valid_addr {addr != 3;}
   constraint valid_length {length > 0 && length <64;}
   constraint valid_size {payload.size() == length;}
   constraint dist_parity {parity_type dist {BAD_PARITY:=1, BAD_PARITY:=5};}
   constraint delay_range {packet_delay >0  && packet_delay <21;}

  // Add methods for parity calculation and class construction
  
  function new(string name = "yapp_packet");
    super.new(name);
  endfunction : new
  
  function bit [7:0] calc_parity();
     parity = {length, addr};
     foreach(payload[i]) begin
        parity = parity ^ payload[i];
     end
  endfunction: calc_parity
  
  function void set_parity();
     parity = calc_parity();
     if(parity_type == BAD_PARITY)
        parity = ~parity;
  endfunction : set_parity
  
  function void post_randomize();
       set_parity();
  endfunction: post_randomize

endclass: yapp_packet
