with Interface_Server;
with Method_Sum;
with Method_Minus;
with Status;
package body DispatchHandler is

   procedure GenerateInvalidResponse (res : out Response.Response_Type) is
   begin
      Response.SetStatusCode(res => res,
                             c => Status.RPC_INVALID_CONVERSION);
      Response.SetStatusMessage(res => res,
                                msg => "Conversion Error occured.");

   end GenerateInvalidResponse;



   procedure Handle_Sum(req : in Request.Request_Type; res : out Response.Response_Type) is
      procedure ConvertToSpecific is new Request.ConvertToSpecific(Method_Sum.Request.Specific_Data);
      procedure ConvertToResponse is new Response.ConvertToResponse(Method_Sum.Response.Specific_Data);
      specific_req : Method_Sum.Request.Specific_Data;
      specific_res : Method_Sum.Response.Specific_Data;

   begin
      ConvertToSpecific(req => req,
                        data => specific_req);
      if Method_Sum.Request.isValid(specific_req) then

         Interface_Server.Sum(specific_req.x, specific_req.y, specific_res.result);

         ConvertToResponse(data => specific_res,
                           status => Status.RPC_SUCCESS,
                           statusmsg => "RPC Call Successful",
                           res => res);
      else

         GenerateInvalidResponse(res);

      end if;

   end Handle_Sum;

   procedure Handle_Minus(req : in Request.Request_Type; res : out Response.Response_Type) is
      procedure ConvertToSpecific is new Request.ConvertToSpecific(Method_Minus.Request.Specific_Data);
      procedure ConvertToResponse is new Response.ConvertToResponse(Method_Minus.Response.Specific_Data);
      specific_req : Method_Minus.Request.Specific_Data;
      specific_res : Method_Minus.Response.Specific_Data;

   begin
      ConvertToSpecific(req => req,
                        data => specific_req);
      if Method_Minus.Request.isValid(specific_req) then

         Interface_Server.Minus(specific_req.x, specific_req.y, specific_res.result);

         ConvertToResponse(data => specific_res,
                           status => Status.RPC_SUCCESS,
                           statusmsg => "RPC Call Successful",
                           res => res);
      else

         GenerateInvalidResponse(res);

      end if;

   end Handle_Minus;

end DispatchHandler;
