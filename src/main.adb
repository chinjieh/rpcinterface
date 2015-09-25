with Ada.Text_IO; use Ada.Text_IO;
with Interface_Client;
with Interface_Status; use type Interface_Status.StatusType;

procedure main is

   result : Integer;
   code : Interface_Status.StatusType;

begin
   Put_Line("Starting..");
   Interface_Client.Init(addr => "./temp/socket.temp");
   Interface_Client.Sum(20,5,result, code);
   Put_Line("Code received: ");
   Put_Line(code'Img);
   if (code = Interface_Status.Rpc_Success) then

       Put_Line("Result is : " & Integer'Image(result));

     end if;

   Interface_Client.Sum(4,6,result, code);
   Put_Line("Result is : " & Integer'Image(result));

   Interface_Client.Minus(4,6,result, code);
   Put_Line("Result is : " & Integer'Image(result));


end main;
