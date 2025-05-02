module Sequencia (
    input wire clk,
    input wire rst_n,

    input wire setar_palavra,
    input wire [7:0] palavra,

    input wire start,
    input wire bit_in,

    output reg encontrado
);

reg [7:0] pattern;
    reg [7:0] shift_reg;
    reg       running;

    always @(posedge clk) begin
        if (!rst_n) begin
            pattern    <= 8'd0;
            shift_reg  <= 8'd0;
            running    <= 1'b0;
            encontrado <= 1'b0;
        end else begin
            if (setar_palavra) begin
                pattern    <= palavra;
                shift_reg  <= 8'd0;
                running    <= 1'b0;
                encontrado <= 1'b0;
            end else begin
                if (start) begin
                    running <= 1'b1;
                end

                if (running && !encontrado) begin
                    shift_reg <= { shift_reg[6:0], bit_in };
                    if ({ shift_reg[6:0], bit_in } == pattern) begin
                        encontrado <= 1'b1;
                    end
                end
            end
        end
    end

endmodule
