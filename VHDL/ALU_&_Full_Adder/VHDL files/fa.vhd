library IEEE;
use IEEE.std_logic_1164.all;

entity fa is
port(X,Y,Z : in bit;     
     U,V : out bit);    
end fa;

architecture behavior of fa is
begin
    U <= X xor Y xor Z; --Sum
    V <= (X and Y) or ((X xor Y) and Z); --Carry out
end behavior;
