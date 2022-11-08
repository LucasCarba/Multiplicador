entity fulladder is
 port (X,Y,Cin: in Bit; Cout, Sum: out Bit);
end fulladder;

architecture ecuacion of fulladder is
begin
 Sum <= X xor Y xor Cin;
 Cout <= (X and Y) or (X and Cin) or (Y and Cin);
end;

