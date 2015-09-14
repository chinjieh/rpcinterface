with Ada.Text_IO; use Ada.Text_IO;
with Anet.Streams;
with Dispatcher;


package body Channel_Server is

   socket : aliased Anet.Sockets.Unix.TCP_Socket_Type;


   -------------------------------------------------------------------------

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

   procedure Bind (addr : in String) is
   begin
      socket.Bind(Path => Anet.Sockets.Unix.Path_Type(addr));
      Put_Line("Bound socket to: " & addr);
   end Bind;

   procedure Listen_Respond is

      package Unix_TCP_Receiver is new Anet.Receivers.Stream
     (Socket_Type => Anet.Sockets.Unix.TCP_Socket_Type);

      receiver : Unix_TCP_Receiver.Receiver_Type(socket'Access);

      procedure Handle_Request
           (Recv_Data :     Ada.Streams.Stream_Element_Array;
            Send_Data : out Ada.Streams.Stream_Element_Array;
            Send_Last : out Ada.Streams.Stream_Element_Offset) is

         stream_req : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Request.REQUEST_SIZE);
         stream_res : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Response.RESPONSE_SIZE);
         req : Request.Request_Type;
         res : Response.Response_Type;

      begin
         Put_Line("Client connected.");
         stream_req.Set_Buffer(Buffer=> Recv_Data);
         Request.Request_Type'Read(stream_req'Access, req);


         -- Note: Call Dispatcher.Dispatch to pass Request to higher levels and
         -- obtain Response.
         Dispatcher.Dispatch(req, res);

         Response.Response_Type'Write(stream_res'Access, res);

            -- Get raw buffer from Anet Stream Response and write to output buffer
            --- First splice the Send_Data array to match the Response length
         Put_Line("Sending Response to Client...");
         Send_Last := stream_res.Get_Buffer'Length;
         Send_Data (Send_Data'First .. Send_Last) := stream_res.Get_Buffer;

         Put_Line("Response sent.");

            --
            -- Convert Request's Data to Specific Request
            --ConvertToSpecific(req.Data, specific_req);
            --Put_Line("Request received. Method Code: " & Request.MethodCodeType'Image(Request.getMethodCode(req)));
            --specific_res.result := specific_req.x + specific_req.y;

            --ConvertToResponse(specific_res, res.Data);
            --Response.SetStatusCode(res, Status.RPC_SUCCESS);
            --Response.SetStatusMessage(res, "Success!");

            -- Write data to Anet Stream Response

      end Handle_Request;
   begin

      receiver.Listen(Callback => Handle_Request'Access);

   end Listen_Respond;



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




end Channel_Server;
