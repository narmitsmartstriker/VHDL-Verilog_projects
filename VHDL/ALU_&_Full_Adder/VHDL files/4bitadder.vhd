library ieee;
use ieee.std_logic_1164.all;

entity adder_4bit is
port(x,y : in bit_vector(3 downto 0);
cin : in bit;
sum : out bit_vector(3 downto 0);
cout : out bit);
end adder_4bit;

architecture data1 of adder_4bit is
signal cary : bit_vector(2 downto 0);


component fa is
port(X,Y,Z : in bit;     
     U,V : out bit);      
end component;

begin 
a0 : fa port map (x(0),y(0), cin,sum(0),cary(0));
a1 : fa port map (x(1),y(1), cary(0),sum(1),cary(1));
a2 : fa port map (x(2), y(2), cary(1), sum(2), cary(2));
a3 : fa port map (x(3), y(3), cary(2), sum(3), cout);

end data1;
