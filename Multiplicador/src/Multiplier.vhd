
ENTITY Multiplier is

PORT(A,B:in Bit_Vector(3 downto 0);STB:in bit;Clok:in bit;Result: out Bit_vector(7 downto 0));

end Multiplier;


Architecture estructura of Multiplier is 

component ShiftN is
   port (CLK: in Bit; CLR: in Bit; LD: in Bit; SH: in Bit; DIR: in Bit; D: in Bit_Vector; 
		Q: out Bit_Vector);
end component;

component Adder8 is      
port (A, B: in Bit_Vector(7 downto 0); Cin: in Bit; 
   Cout: out Bit; Sum: out  Bit_Vector(7 downto 0));		 
end component;

component Latch8 is
   port (D: in Bit_Vector(7 downto 0); CLk: in Bit; Pre: in Bit; 
   Clr: in Bit; Q: out Bit_Vector(7 downto 0));
end component;


component Controller is   
port (STB, CLK, LSB, Stop: in  Bit;
     Init, Shift, Add, Done: out  Bit);
end component;

signal salida_SRB: Bit_Vector(7 downto 0);
signal salida_SRA: Bit_Vector(7 downto 0);
signal salida_adder: Bit_Vector(7 downto 0);
signal salida_ACC: Bit_Vector(7 downto 0);
signal shift:bit;
signal init:bit;
signal init_bar:bit;
signal add:bit;
signal stop:bit;
signal done:bit;
signal Cout: bit;
signal salidaA_lsb: bit;
signal Clok_bar: bit;
begin
    --Sincronizacion multiplicador
	init_bar<= not init;	
	Clok_bar<= not Clok;
	salidaA_lsb<= salida_SRA(0);
	--registro SRB
	SRB: ShiftN  port map (CLK=>Clok,CLR=>'0',LD=>init,SH=>shift,DIR=>'1',D=>B,Q=>salida_SRB);
	--registro SRA
	SRAA: ShiftN  port map (CLK=>Clok,CLR=>'0',LD=>init,SH=>shift,DIR=>'0',D=>A,Q=>salida_SRA);
	--sumador 
	adderr: Adder8 port map(A=>salida_ACC,B=>salida_SRB, Cin=>'0',Cout=>Cout, Sum=>salida_adder);
	--registro acumulador
	ACC: Latch8 port map (D=>salida_adder, CLk=>add, Pre=>'1',  Clr=>init_bar, Q=>salida_ACC);
	--registro de resultado
	resultado: Latch8 port map (D=>salida_ACC, CLk=>done, Pre=>'1', Clr=>init_bar, Q=>Result);
     --maquina de estado
	FSM :Controller port map (STB=>STB, CLK=>Clok_bar, LSB=>salidaA_lsb,Stop=>stop, 
	Init=>init, Shift=>shift, Add=>add, Done=>done);
	--compuerta NOR	
	stop<=  not( salida_SRA(7) or salida_SRA(6) or salida_SRA(5) or salida_SRA(4) 
			 or salida_SRA(3) or salida_SRA(2) or salida_SRA(1) or salida_SRA(0));
end estructura;
