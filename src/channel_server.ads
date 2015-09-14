with Request;
with Response;
with Anet.Sockets.Unix;
with Ada.Streams;
with Anet.Receivers.Stream;

package Channel_Server is



   subtype ConnectString is String (1..128);


   -- Function to initialise Channel
   procedure Init;

   -- Function to bind addr
   procedure Bind (addr : in String);

   -- Function to Listen for Request and Send a Response
   --- Call Dispatcher.Dispatch in the code
   procedure Listen_Respond;

end Channel_Server;
