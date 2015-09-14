with Response;
with Request;
package Dispatcher is

   procedure Dispatch(req : in Request.Request_Type; res : out Response.Response_Type);

end Dispatcher;
