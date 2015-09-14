with Ada.Text_IO; use Ada.Text_IO;
with Interface_Client; use type Interface_Client.StatusType;

procedure main is

   result : Integer;
   code : Interface_Client.StatusType;

begin
   Put_Line("Starting..");
   Interface_Client.Init(addr => "./temp/socket.temp");
   Interface_Client.Sum(20,5,result, code);
   Put_Line(code'Img);
   if (code = Interface_Client.Rpc_Status_Success) then

       Put_Line("Result is : " & Integer'Image(result));

     end if;

   Interface_Client.Sum(4,6,result, code);
   Put_Line("Result is : " & Integer'Image(result));

   Interface_Client.Minus(4,6,result, code);
   Put_Line("Result is : " & Integer'Image(result));


end main;
