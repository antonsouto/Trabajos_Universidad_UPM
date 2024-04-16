library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY SecMoore is
port(   
    sDatain     :   in std_logic ;
    clk         :   in std_logic ;
    reset       :   in std_logic ;
    sDetect     :   out std_logic );
end entity;


architecture secmoorearch of SecMoore is

TYPE TipoEstados IS (E0,E1,E10,E101,E1011);
SIGNAL tESTADOACTUAL, tESTADOSIGUIENTE: TipoEstados ;
subtype ticks is integer range 0 to 4;
signal remaining_ticks: ticks ;
begin

state_register:PROCESS (clk, RESET)
begin   
    IF reset = '1' then
        tESTADOACTUAL <= E0 ;
    ELSIF rising_edge(clk) then
        tESTADOACTUAL <= tESTADOSIGUIENTE ;
    END IF;
END PROCESS state_register ;

NEXTSTATE:PROCESS(sDatain ,tESTADOACTUAL )
    begin
    CASE tESTADOACTUAL is
        WHEN E0 => 
            IF sDatain = '0' then
                tESTADOSIGUIENTE <= E1;
            end if;
        
        WHEN E1 => 
            IF sDatain = '0' then
                tESTADOSIGUIENTE <= E10;
            end if;
        WHEN E10 => 
            IF sDatain = '1' then
                tESTADOSIGUIENTE <= E101;
            end if;
        WHEN E101 => 
            IF  sDatain = '1' then
                tESTADOSIGUIENTE <= E1011;
            end if;
        WHEN E1011 => 
            IF sDatain = '1' then
                tESTADOSIGUIENTE <= E1;
                ELSE tESTADOSIGUIENTE <= E0;
            end if;
    end case;
end process NEXTSTATE ;

currentstate:PROCESS(CLK)
begin
    CASE tESTADOACTUAL is 
         WHEN E0 => sDetect <= '0';
         WHEN E1 => sDetect <= '0';
         WHEN E10 => sDetect <= '0';
         WHEN E101 => sDetect <= '0';
         WHEN E1011 => sDetect <= '1';
    END CASE;
END PROCESS;

end architecture secmoorearch ;