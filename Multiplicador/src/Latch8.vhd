entity Latch8 is
   port (D: in Bit_Vector(7 downto 0); Clk: in Bit; Pre: in Bit; Clr: in Bit; Q: out Bit_Vector(7 downto 0));
end Latch8;

architecture Estructura of Latch8 is
   component DFF
       port (Preset: in Bit; Clear: in Bit; Clock: in Bit; Data: in Bit; Q: out Bit; QBar: out Bit);
   end component;
   signal QBar: Bit_Vector(7 downto 0);
begin
F7: DFF port map (Pre, Clr, Clk, D(7), Q(7), QBar(7));
F6: DFF port map (Pre, Clr, Clk, D(6), Q(6), QBar(6));
F5: DFF port map (Pre, Clr, Clk, D(5), Q(5), QBar(5));
F4: DFF port map (Pre, Clr, Clk, D(4), Q(4), QBar(4));
F3: DFF port map (Pre, Clr, Clk, D(3), Q(3), QBar(3));
F2: DFF port map (Pre, Clr, Clk, D(2), Q(2), QBar(2));
F1: DFF port map (Pre, Clr, Clk, D(1), Q(1), QBar(1));
F0: DFF port map (Pre, Clr, Clk, D(0), Q(0), QBar(0));
end;

