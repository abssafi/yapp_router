class yapp_tx_monitor extends uvm_monitor;
    `uvm_component_utils(yapp_tx_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new //new

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"Simulation starts for: ", get_full_name()}, UVM_HIGH)
    endfunction: start_of_simulation_phase

    task run_phase(uvm_phase phase);
        forever begin
            `uvm_info("INFO", "You are in monitor!", UVM_LOW)
             #10ns;
        end 
    endtask: run_phase
     

endclass: yapp_tx_monitor