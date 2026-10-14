
module security_system;

    reg door_open;
    reg password_ok;
    reg system_armed;

    reg alarm;
    reg access_granted;

    // Conditional circuit logic
    always @(*) begin
        alarm = 0;
        access_granted = 0;

        if (system_armed == 1) begin
            if (door_open == 1) begin
                if (password_ok == 1)
                    access_granted = 1;
                else
                    alarm = 1;
            end
        end
    end

    // Testbench and waveform generation
    initial begin
        $dumpfile("security.vcd");
        $dumpvars(0, security_system);

        $display("SMART ROOM SECURITY SYSTEM");
        $display("--------------------------------");

        // Test 1: Door Closed
        system_armed = 1;
        door_open = 0;
        password_ok = 0;
        #10;
        $display("Test 1: Door Closed | Alarm=%b Access=%b",
                 alarm, access_granted);

        // Test 2: Wrong Password
        door_open = 1;
        password_ok = 0;
        #10;
        $display("Test 2: Wrong Password | Alarm=%b Access=%b",
                 alarm, access_granted);

        // Test 3: Correct Password
        password_ok = 1;
        #10;
        $display("Test 3: Correct Password | Alarm=%b Access=%b",
                 alarm, access_granted);

        // Test 4: Security System OFF
        system_armed = 0;
        password_ok = 0;
        #10;
        $display("Test 4: System OFF | Alarm=%b Access=%b",
                 alarm, access_granted);

        $display("--------------------------------");
        $display("Simulation Completed Successfully");

        $finish;
    end

endmodule
