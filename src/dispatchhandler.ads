with Request;
with Response;
package DispatchHandler is

   procedure GenerateInvalidResponse (res : out Response.Response_Type);

   ---------------------------------------------
   -- Specific Handlers for different methods --
   ---------------------------------------------
   procedure Handle_Sum(req : in Request.Request_Type; res : out Response.Response_Type);

   procedure Handle_Minus(req : in Request.Request_Type; res : out Response.Response_Type);

end DispatchHandler;

