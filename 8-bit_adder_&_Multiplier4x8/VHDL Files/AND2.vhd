library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is
 port(P,Q : in std_logic;     
       R : out std_logic);    
end AND2;

architecture df of AND2 is
 begin
    R <= P and Q;
end df;  
