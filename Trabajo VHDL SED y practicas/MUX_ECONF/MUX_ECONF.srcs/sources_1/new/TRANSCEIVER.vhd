----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 18:47:02
-- Design Name: 
-- Module Name: TRANSCEIVER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TRANSCEIVER is
    GENERIC ( WIDTH : POSITIVE := 8);
    PORT( A,B :inout std_logic_vector(WIDTH-1 downto 0);
          DIR : IN std_logic
          );
              
end TRANSCEIVER;

architecture dataflow of TRANSCEIVER is
begin
    A <= B WHEN DIR = '0' ELSE 
    (OTHERS => 'Z');-- importante :DEBE PONERSE ESTO PARA QUE CUANDO A CAMBIE A ENTRADA NO DEJE SALIR NADA PERO SI ENTRAR
    B <= A WHEN DIR = '1' ELSE 
    (OTHERS => 'Z') ; --SE PONE PARENTESIS PORQUE ES UN AGREGADO AUNQUE SOLO TENGA "OTHERS" ,
                      --EJEMPLO DE ESTO SERIA HACER UNA ASIGNACION ('1','0', OTHERS => 'Z') TAMBIEN VALIDA
                      --AUNQUE NO CORRECTA PARA EL EJEMPLO SI LO ES SEMANTICAMENTE
    

end dataflow;
