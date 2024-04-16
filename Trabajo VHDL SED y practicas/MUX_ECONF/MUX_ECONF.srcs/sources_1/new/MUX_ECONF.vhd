----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2022 18:29:22
-- Design Name: 
-- Module Name: MUX_ECONF - Behavioral
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

entity MUX_ECONF is
    GENERIC (N: INTEGER := 4);
    PORT (X0,X1,X2,X3: IN std_logic_vector(N-1 DOWNTO 0);
        SEL: IN std_logic_vector (1 downto 0);
        Y: OUT std_logic_vector(N-1 downto 0)
        );
end MUX_ECONF;

architecture DATAFLOW_WHEN of MUX_ECONF is
begin
    Y <= X0 WHEN SEL = "00" else
        X1 WHEN SEL = "01" else
        X2 WHEN SEL = "10" else
        X3;
        -- CON ESTA EXPRESION NO SE PUEDE USAR "OTHERS" PORQUE ESTAMOS EVALUANDO CONDICIONES, QUE EN ESTE CASO ES UNA VARIABLE PERO NO TIENE POR QUE 
        -- SER SOLO UNA, ES DECIR, PUEDE SER CUALQUIER COSA Y TIENES QUE PONERLA PARA PODER EVALUARLA.
        
end DATAFLOW_WHEN;

architecture DATAFLOW_WITH_SELECT OF MUX_ECONF is
begin
    WITH SEL select --DEBEMOS CUBRIR OBLIGATORIAMENTE TODOS LOS VALORES DE "SEL", QUE ES UN STDLOGIC, POR LO QUE DEBEMOS PONER OTHERS PARA CUBRIRLAS TODAS.
        Y <= X0 WHEN "00",
             X1 WHEN "01",
             X2 WHEN "01",
             X3 WHEN OTHERS;
              


END DATAFLOW_WITH_SELECT;