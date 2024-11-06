module debouncer(
    btn,
    sampling_clk, //use the display clock
    debounced_signal
)
    input wire btn
    input wire sampling_clk
    output reg debounced_signal

    debounced_signal = 0
    always @ (posedge sampling_clk) begin
        debounced_signal <= btn
    end

endmodule


module buttonDebouncer(
    btn,
    sampling_clk,
    rising_debounced_signal
)
    input wire btn
    input wire sampling_clk
    output reg rising_debounced_signal
    reg debounced_signal
    reg [2:0] step_d <= 0
    debouncer db_inst (
        .btn(btn),
        .sampling_clk(sampling_clk),
        .debounced_signal(debounced_signal)
    );
    always @ (posedge sampling_clk) begin
        step_d[2:0]  <= {debounced_signal, step_d[2:1]};
    end

    always @ (posedge clk) begin
        rising_debounced_signal <= ~step_d[0] & step_d[1];
    end
endmodule