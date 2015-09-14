with Request;
with Response;

package Channel_Client is

   subtype ConnectString is String (1..128);


   -- Function to initialise Channel
   procedure Init;

   -- Function to connect to addr
   procedure Connect (addr : in String);


   -- Function to Send Request, and receive Response
   procedure Send_Receive(req : in Request.Request_Type;
                          res : out Response.Response_Type);

end Channel_Client;
