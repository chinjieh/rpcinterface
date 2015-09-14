with Anet.Sockets.Unix;
with Anet.Streams;
with Ada.Streams;
with Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Anet.Receivers.Stream;
with Request;
with Response;
with Status;
with Dispatcher;

--------------------
-- OBSELETE FILE-------
----------------------
procedure server is

   package Unix_TCP_Receiver is new Anet.Receivers.Stream
     (Socket_Type => Anet.Sockets.Unix.TCP_Socket_Type);

   socket : aliased Anet.Sockets.Unix.TCP_Socket_Type;
   receiver : Unix_TCP_Receiver.Receiver_Type(socket'Access);

   procedure Handle_Request
     (Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset)
   is
      stream_req : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Request.REQUEST_SIZE);
      stream_res : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Response.RESPONSE_SIZE);
      req : Request.Request_Type;
      res : Response.Response_Type;

   begin
      Put_Line("Client connected.");
      stream_req.Set_Buffer(Buffer=> Recv_Data);
      Request.Request_Type'Read(stream_req'Access, req);


      -- Dispatch to Correct Method Handler
      Dispatcher.Dispatch(req, res);

      -- Write data to Anet Stream Response
      Response.Response_Type'Write(stream_res'Access, res);

      -- Get raw buffer from Anet Stream Response and write to output buffer
      --- First splice the Send_Data array to match the Response length
      Put_Line("Sending Response to Client...");
      Send_Last := stream_res.Get_Buffer'Length;
      Send_Data (Send_Data'First .. Send_Last) := stream_res.Get_Buffer;

      Put_Line("Response sent.");

   exception
      when E : others =>
         Put_Line("Exception occured in server callback: " & Ada.Exceptions.Exception_Information(E));
   end Handle_Request;


begin



   socket.Init;
   Put_Line("Server binding...");
   socket.Bind(Path => "./temp/socket.temp");

   Put_Line("Listening on address: " & "./temp/socket.temp");
   receiver.Listen(Callback => Handle_Request'Access);

   --TODO : Shift server code to channel / interface_server. Main_Server will run
   --this code instead.

end server;
