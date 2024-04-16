
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SIPO32BIT is
  generic( N : integer := 4);
  Port (
    clk     :   in bit;
    ss_n    :   in bit;
    rdy_in  :   in bit;
    sin     :   in bit;
    
    pout    :   out bit_vector (8*N-1 downto 0);
    rdy_out :   out bit
  );
end SIPO32BIT;

architecture STRUCTURAL of SIPO32BIT is

component SIPO is
    port(                          ---------------------ENTRADAS 
        CLK     :   IN bit ; --RELOJ DEL SISTEMA 
        SS_N    :   IN bit ; --RESET ASINCRONO NEGADO , PONE A 0 LA CUENTA Y EL REGISTRO DE DESPLAZAMIENTO 
        RDY_IN  :   IN bit ; --SOLO SE CUENTA CUANDO ESTA ENTRADA ESTA A '1'
        SIN     :   IN bit ; --ENTRADA SERIE 
                                  ----------------------SALIDAS 
        POUT    :   OUT bit_vector (7 downto 0); --SALIDA DE DATOS PARALELA 
        RDY_OUT :   OUT bit ); --FIN DE LA RECEPCION = '1'
end component;

    signal rdy_i : bit_vector( 3 downto 0);
    signal pout_i: bit_vector(31 downto 0);
begin
    bundle: for i in 3 downto 0 generate
        unit_3: if i = 3 generate
            u3: SIPO
                    port map (
                    CLK => CLK,
                    SS_N => SS_N,
                    RDY_IN => RDY_IN,
                    SIN => sin,
                    POUT => pout_i(31 downto 24),
                    RDY_OUT => rdy_i(3)
                    );
                end generate;
        unit_i: if i /= 3 generate
            ui: SIPO
                    port map (
                    CLK => CLK,
                    SS_N => SS_N,
                    RDY_IN => rdy_i(i + 1),
                    SIN => pout_i(8 * (i + 1)),--ESTO SOLO FUNCIONA CON EL CODIGO DEL PROFESOR QUE ESTABA CHINADO ESE PUTO DIA Y PUSO UNA LOCURA
                    POUT => pout_i(8 * (i + 1) - 1 downto 8 * i),
                    RDY_OUT => rdy_i(i)
            );
             end generate;
    end generate;
 POUT <= pout_i;
 RDY_OUT <= rdy_i(0);
end STRUCTURAL;
