with Channel_Server;
with Response;
with Request;
package body Interface_Server is
   package Channel renames Channel_Server;

   procedure Start (addr : String) is

   begin
      Channel.Init;
      Channel.Bind(addr => addr);
      Channel.Listen_Respond;

   end Start;


   procedure Sum (x : Integer; y : Integer; result : out Integer) is
   begin
      result := x + y;
   end Sum;

   procedure Minus (x : Integer; y : Integer; result : out Integer) is
   begin
      result := x - y;
   end Minus;



end Interface_Server;
