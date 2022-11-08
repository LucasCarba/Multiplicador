entity Adder8 is
          port (A, B: in Bit_Vector(7 downto 0); Cin: in Bit; Cout: out Bit; Sum: out  Bit_Vector(7 downto 0));
end Adder8;

architecture Estructura of Adder8 is
          component FullAdder
            port (X, Y: in Bit; Cin: in Bit; Cout: out Bit; Sum: out Bit);
          end component;
          signal C: Bit_Vector(7 downto 0);
begin
          Stages:
            for i in 7 downto 0 generate
              LowBit:
                if i = 0 generate
                  FA: FullAdder port map
                        (A(0), B(0), Cin, C(0), Sum(0));
                end generate;
              OtherBits:
                if i /= 0 generate
                  FA: FullAdder port map
                        (A(i), B(i), C(i-1), C(i), Sum(i));
                end generate;
            end generate;
          Cout <= C(7);
end;
