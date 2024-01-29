`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2023 23:12:11
// Design Name: 
// Module Name: SPI_tb
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


module SPI_tb();

reg CLOCK;   
reg RST;          
reg MISO;         
reg [63:0]DATA_in;
reg read_en;      
reg wire_en;      
reg [7:0]counter;      
reg [1:0]SLAVE;     
reg [6:0]data_length; 
reg [1:0]MODE; 

wire MOSI;  
wire SS0;   
wire SS1;   
wire SS2;   
wire SCK;
    
SPI SPI(
CLOCK,        
RST,         
MISO,          
DATA_in, 
read_en,       
wire_en,       
counter,       
SLAVE,  
data_length, 
MODE,          
MOSI,         
SS0,          
SS1,          
SS2,          
SCK          
);

initial begin
    counter <= 1;
    CLOCK <= 0;
    RST <= 1;
    read_en <= 0;
    wire_en <= 1;
    SLAVE <= 0;
    data_length <= 32;
    MISO <= 0;
    MODE = 2;
    DATA_in <= 64'b11111111111111111111111111000000;
    #40
    RST <= 0;
    #2670
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #840
    DATA_in <= 64'b11111111111111111111111111000000;
    read_en <= 0;
    wire_en <= 1;
    data_length <= 32;
    //
    #670
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    //
    #670
    MISO <= 0;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    //
    #670
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #335
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #335
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    //
    #840
    DATA_in <= 64'b11111111111111111111111111000000;
    read_en <= 0;
    wire_en <= 1;
    data_length <= 32;
    #2680
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #840
    DATA_in <= 64'b11111111111111111111111111000000;
    read_en <= 0;
    wire_en <= 1;
    data_length <= 32;
    #2680
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #840
    DATA_in <= 64'b0000000000111111111111111111111111010000;
    read_en <= 0;
    wire_en <= 1;
    data_length <= 40;
    counter <= 0;
    #830
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 16;
    #370
    MODE = 1;
    counter <= 100;
    SLAVE = 1;
    read_en <= 0;
    wire_en <= 1;   
    DATA_in <= 64'b01001111;
    data_length <= 8;
    #46460
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #44440
    read_en <= 0;
    wire_en <= 1;   
    DATA_in <= 64'b11001111;
    data_length <= 8;
    #36360
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #44440
    read_en <= 0;
    wire_en <= 1;   
    DATA_in <= 64'b00101111;
    data_length <= 8;
    #36360
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #44440
    read_en <= 0;
    wire_en <= 1;   
    DATA_in <= 64'b10101111;
    data_length <= 8;
    #46460
    MISO <= 1;
    read_en <= 1;
    wire_en <= 0;
    data_length <= 8;
    #44440
    MODE <= 2;
    SLAVE <= 0;
    read_en <= 0;
    wire_en <= 1; 
    data_length <= 40;
    DATA_in <= 64'b1111111111011111111111111111111101000000;    
    counter <= 1;
    #3240
    SLAVE <= 2;    
    counter <= 1;
    DATA_in <= 64'b11111111;    
    data_length <= 8;
    read_en <= 0;
    wire_en <= 1;
end 

always #10 CLOCK=~CLOCK;



endmodule
