`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2023 20:21:50
// Design Name: 
// Module Name: SPI
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


module SPI(
input CLOCK,
input RST,
input MISO,
input [63:0]DATA_in,
input read_en,
input write_en,
input [7:0] counter,
input [1:0]SLAVE,
input [6:0]data_length,
input [1:0]MODE,

output reg MOSI,
output reg SS0,
output reg SS1,
output reg SS2,
output reg SS3,
output reg SCK
);

logic [9:0]d_f;
logic [63:0]DATA;
logic [6:0]length;
logic [63:0]DATA_OUT; 
logic [6:0]counter_1; 

initial begin 
    DATA <= DATA_in;
    DATA_OUT <= 0;
    d_f <= 0;
    SCK <= 0;
end;

enum logic [2:0] {   IDLE = 3'b000,
                     RorW = 3'b001,
                     START_R = 3'b010,
                     START_W = 3'b011,
                     STOP = 3'b100} STATE;
   always @(posedge SCK) begin
   if (MODE==2) begin
      if (RST) begin 
         STATE <= IDLE;
      end
      else
         case (STATE)
            IDLE : begin
               MOSI <= 0;
               SS0 <= 1;
               SS1 <= 1;
               SS2 <= 1;
               SS3 <= 1;
               SCK <= 0;
               DATA <= 0;
               counter_1 <= 0; 
               length <= data_length;
               if (read_en) begin
                   STATE <= START_R;
                   case (SLAVE)
                       0: SS0 <= 0;
                       1: SS1 <= 0;
                       2: SS2 <= 0;
                       3: SS3 <= 0;
                   endcase 
               end else begin
                  if (write_en) begin
                    STATE <= START_W;
                    case (SLAVE)
                        0: SS0 <= 0;
                        1: SS1 <= 0;
                        2: SS2 <= 0;
                        3: SS3 <= 0;
                    endcase  
                  end else STATE <= IDLE;
               end
            end
            START_W : begin
                case (SLAVE)
                    0: SS0 = 0;
                    1: SS1 = 0;
                    2: SS2 = 0;
                    3: SS3 = 0;
                endcase                 
                MOSI = DATA_in[counter_1];
                
                counter_1 = counter_1 + 1;
                if (counter_1 == data_length) begin 
                    STATE <= STOP;
                end 
            end
            START_R : begin
            
            if (length == 0) begin
                SS0 <= 1;
                SS1 <= 1;
                SS2 <= 1;
                SS3 <= 1;
                STATE <= STOP;
                DATA <= DATA >> 1;
            end else begin
                if (~SS0 || ~SS1 || ~SS2 || ~SS3) DATA <= (DATA | MISO) << 1;
                    length <= length - 1;
            end
            end
            STOP : begin
                  DATA <= 0; 
                  STATE <= IDLE;
            end
         endcase
     end
     end
     
       always @(negedge SCK) begin
   if (MODE==1) begin
      if (RST) begin 
         STATE <= IDLE;
      end
      else
         case (STATE)
            IDLE : begin
               MOSI <= 0;
               SS0 <= 1;
               SS1 <= 1;
               SS2 <= 1;
               SS3 <= 1;
               SCK <= 0;
               DATA <= 0;
               counter_1 <= 0; 
               length <= data_length;
               if (read_en) begin
                   STATE <= START_R;
                   case (SLAVE)
                       0: SS0 <= 0;
                       1: SS1 <= 0;
                       2: SS2 <= 0;
                       3: SS3 <= 0;
                   endcase 
               end else begin
                  if (write_en) begin
                    STATE <= START_W;
                    case (SLAVE)
                        0: SS0 <= 0;
                        1: SS1 <= 0;
                        2: SS2 <= 0;
                        3: SS3 <= 0;
                    endcase  
                  end else STATE <= IDLE;
               end
            end
            START_W : begin
                case (SLAVE)
                    0: SS0 = 0;
                    1: SS1 = 0;
                    2: SS2 = 0;
                    3: SS3 = 0;
                endcase                 
                MOSI = DATA_in[counter_1];
                
                counter_1 = counter_1 + 1;
                if (counter_1 == data_length ) begin 
                    STATE <= STOP;
                end 
            end
            START_R : begin
            
            if (length == 0) begin
                SS0 <= 1;
                SS1 <= 1;
                SS2 <= 1;
                SS3 <= 1;
                STATE <= STOP;
                DATA <= DATA >> 1;
            end else begin
                if (~SS0 || ~SS1 || ~SS2 || ~SS3) DATA <= (DATA | MISO) << 1;
                    length <= length - 1;
            end
            end
            STOP : begin
                  DATA <= 0; 
                  STATE <= IDLE;
            end
         endcase
     end
     end
          
always@(posedge CLOCK) begin
    if ( counter != 0) begin
     if (d_f == counter) begin
      d_f <= 0;
      SCK <= ~SCK;
    end else begin
      d_f <= d_f + 1;
    end
    end
end  

always@(posedge CLOCK or negedge CLOCK) begin
    if ( counter == 0) 
      SCK <= ~SCK;
end

endmodule
