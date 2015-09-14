with Ada.Text_IO; use Ada.Text_IO;
with Anet.Streams;
with Anet.Sockets.Unix;
with Ada.Streams;
with Dispatcher;


package body Channel_Client is

   socket : aliased Anet.Sockets.Unix.TCP_Socket_Type;

   procedure Init is
   begin
      socket.Init;
      Put_Line("Initialised socket.");
   end Init;

   procedure Connect(addr : in String) is
   begin
      socket.Connect(Path => Anet.Sockets.Unix.Path_Type(addr));
      Put_Line("Connected to: " & addr);
   end Connect;


   procedure Send_Receive(req : in Request.Request_Type;
                          res : out Response.Response_Type) is

      send_stream : aliased Anet.Streams.Memory_Stream_Type(Max_Elements=> Request.REQUEST_SIZE);
      recv_data : Ada.Streams.Stream_Element_Array(1 .. Response.RESPONSE_SIZE);
      recv_offset : Ada.Streams.Stream_Element_Offset;
      recv_stream : aliased Anet.Streams.Memory_Stream_Type(Max_Elements=>Response.RESPONSE_SIZE);

   begin

      Request.Request_Type'Write(send_stream'Access, req);
      socket.Send(Item => send_stream.Get_Buffer);
      Put_Line("Sent data to server. Waiting for Reply...");

      socket.Receive(Item => recv_data,
                     Last => recv_offset);
      Put_Line("Reply received from server.");
      recv_stream.Set_Buffer(Buffer => recv_data);
      Response.Response_Type'Read(recv_stream'Access, res);

   end Send_Receive;




end Channel_Client;
