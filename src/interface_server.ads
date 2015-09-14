with Anet.Sockets.Unix;
with Anet.Streams;
with Anet.Receivers.Stream;
with Request;
with Response;

package Interface_Server is



   procedure Start(addr : in String);

   procedure Sum(x : in Integer; y : in Integer; result : out Integer);

   procedure Minus(x : in Integer; y : in Integer; result : out Integer);


end Interface_Server;
