use STD.textio.all;	
use WORK.Utils.all;

entity Test_Multiplier2 is end;

architecture Driver of Test_Multiplier2 is
constant texto:string:="MULTIPLICADOR- N° 01789/0  - A:Numero de mayor digito (9) - B: Numero de menor digito (1) ";
	constant texto2:string:="Numero A (9)";
	constant texto3:string:="Numero B (1)";
	constant texto4:string:="El resultado de la multiplicacion es:";

	component Multiplier is PORT(A,B:in Bit_Vector(3 downto 0);STB:in bit;Clok:in bit;Result: out Bit_vector(7 downto 0));
	end component;
	
	signal AA:Bit_Vector(3 downto 0);
	signal BB:Bit_Vector(3 downto 0);
	signal STB:bit;
	signal clok:bit;
	signal Result:Bit_vector(7 downto 0);
	
	begin
	 UUT: Multiplier port map (AA, BB, STB, Clok,Result); 
	 Clock(Clok,333.33 ns,333.33 ns);
	 Stimulus: process
		variable buff:LINE;
		variable leerA:Bit_Vector(3 downto 0);
		variable leerB:Bit_Vector(3 downto 0);
		variable numA:Natural;
		variable numB:Natural;
		variable resultado:Natural;
		
		begin	   
			write(buff,texto);
			writeline(output,buff);
			write(buff,texto2);
			writeline(output,buff);
			readline(input,buff);
			read(buff,numA);
			while numA/=9 loop	-- se comprueba que el numero ingresado sea igual a 9
				write(buff,texto2);
				writeline(output,buff);
				readline(input,buff);
				read(buff,numA);
			end loop;		   
			leerA:= Convert(numA,4); -- se convierte el numero 9, en numero de 4 bits
			AA<=leerA;			
			
			write(buff,texto3);
			writeline(output,buff);
			readline(input,buff);
			read(buff,numB);
			while numB/=1 loop	-- se comprueba que el numero ingresado sea igual a 1
				write(buff,texto3);
				writeline(output,buff);
				readline(input,buff);
				read(buff,numB);
			end loop;				
			leerB:= Convert(numB,4); -- se convierte el numero 1, en numero de 4 bits
			BB<=leerB;
			STB<='1';
			wait for 7000 ns; 
			STB<='0';
			wait for 9000 ns;		  
			resultado := Convert(Result); 
			write(buff,texto4);
			writeline(output,buff);
			write(buff,resultado);
			writeline(output,buff);		 		
			wait;	
		end process;	
end;			
			
			
			