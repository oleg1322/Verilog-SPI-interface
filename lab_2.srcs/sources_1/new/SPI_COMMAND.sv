`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 09:02:05
// Design Name: 
// Module Name: SPI_COMMAND
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SPI_COMMAND(
    input logic Master_RST,
    input logic Master_CLK,
    input logic Master_enable,
    input logic Master_read_en,
    input logic Master_write_en,
    input logic [7:0]Master_DATA_in,
    input logic [7:0]Master_MISO_DATA_in,
    input logic Master_SS,
    
    output logic [7:0]DATA,
    output logic [7:0]MISO_DATA_out
);

logic clk_flash;
logic [2:0]counter_flash;
logic [7:0]DATA_flash1;
logic [7:0]DATA_flash2;
logic [7:0]DATA_flash3;
logic [7:0]DATA_flash4;



SPI SPI_flash(Master_RST, 
        clk_flash, 
        Master_enable, 
        Master_read_en, 
        Master_write_en,
        Master_DATA_in,
        Master_MISO_DATA_in,
        Master_SS,
        DATA,
        MISO_DATA_out);
        


endmodule
