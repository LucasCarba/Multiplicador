entity ShiftN is
   port (CLK: in Bit; 
CLR: in Bit; 
LD: in Bit; 
SH: in Bit; 
DIR: in Bit; 
D: in Bit_Vector; 
Q: out Bit_Vector);
begin
  assert (D'Length <= Q'Length)
    report "Entrada D no debe ser mas 'ancha' que la salida Q"
      severity Failure;
end ShiftN;

architecture Behavior of ShiftN is
begin
  Shifter: process (CLR, CLK)
    subtype InBits  is Natural range D'Length-1 downto 0;
    subtype OutBits is Natural range Q'Length-1 downto 0;
    variable State: Bit_Vector(OutBits);
  begin
    if CLR = '1' then
      State := (others => '0');
      Q <= State after 3ns;
    elsif CLK'Event and CLK='1' then
         if LD = '1' then
            State := (others => '0');
            State(InBits) := D;
            Q <= State after 5ns;
         elsif SH = '1' then
            case DIR is
              when '0' => State := '0' & State(State'Left downto 1);
              when '1' => State := State(State'Left-1 downto 0) & '0';
            end case;
            Q <= State after 7ns;
         end if;
    end if;
  end process;
end;
