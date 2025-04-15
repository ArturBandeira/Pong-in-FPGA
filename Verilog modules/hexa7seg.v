module hexa7seg (hexa, display);
    input      [2:0] hexa;
    output reg [6:0] display;

    /*
     *    ---
     *   | 0 |
     * 5 |   | 1
     *   |   |
     *    ---
     *   | 6 |
     * 4 |   | 2
     *   |   |
     *    ---
     *     3
     */
        
    always @(hexa)
    case (hexa)
        3'd0:    display = 7'b1000000;
        3'd1:    display = 7'b1111001;
        3'd2:    display = 7'b0100100;
        3'd3:    display = 7'b0110000;
        3'd4:    display = 7'b0011001;
        3'd5:    display = 7'b0010010;
        3'd6:    display = 7'b0000010;
        3'd7:    display = 7'b1111000;
        default: display = 7'b1111111;
    endcase
endmodule
