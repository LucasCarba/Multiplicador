entity Controller is
  port (STB, CLK, LSB, Stop: in  Bit;
           Init, Shift, Add, Done: out  Bit);
end Controller;

architecture FSM of Controller is
  type States is (InitS, CheckS, AddS, ShiftS, EndS);
  signal State: States := EndS;
begin
-- Drive control outputs based upon State
  Init  <= '1' when State = InitS  else '0';
  Add <= '1' when State = AddS   else '0';
  Shift <= '1' when State = ShiftS else '0';
  Done <= '1' when State = EndS else '0';

-- Determine Next State from control inputs
  StateMachine: process (CLK)
    begin
      if CLK'Event and CLK = '0' then
        case State is
          when InitS =>
            State <= CheckS;		
          when CheckS =>
            if LSB = '1' then
               State <= AddS;
            elsif Stop = '0' then
               State <= ShiftS;
            else
               State <= EndS;
            end if;
          when AddS =>
            State <= ShiftS;
          when ShiftS =>
            State <= CheckS;
          when EndS =>
            if STB = '1' then
               State <= InitS;
            end if;
        end case;
      end if;
    end process;
end;

