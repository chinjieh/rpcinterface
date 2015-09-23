with Method_Sum;
with Method_Minus;
with Method;
with Request;
with Response;
with Channel_Client;
with Interface_Status;
with Interfaces;
with Ada.Text_IO;

package body Interface_Client is
   package Channel renames Channel_Client;


   procedure Init (addr : in String) is
   begin
      Channel.Init;
      Channel.Connect(addr);
   end Init;


   procedure Sum (x : in Integer; y : in Integer; result : out Integer; rpc_status : out StatusType) is
      specific_req : Method_Sum.Request.Specific_Data;
      specific_res : Method_Sum.Response.Specific_Data;
      req : Request.Request_Type;
      res : Response.Response_Type;
      procedure ConvertToRequest is new Request.ConvertToRequest(Method_Sum.Request.Specific_Data);
      procedure ConvertToSpecific is new Response.ConvertToSpecific(Method_Sum.Response.Specific_Data);

   begin
      specific_req.x := x;
      specific_req.y := y;
      ConvertToRequest(data => specific_req,
                       code => Method.METHOD_SUM,
                       req => req);

      Channel.Send_Receive(req, res);

      rpc_status := Interface_Status.Code_To_Enum(res.Header.Status_Code);

      ConvertToSpecific(res, specific_res);

      -- Check if Data is valid
      if Method_Sum.Response.isValid(specific_res) then
         result := specific_res.result;
      else
         --TODO dont raise exception
         -- Check status success
         --- Convert if successful

         raise Invalid_Conversion_From_Response;
      end if;

   end Sum;


   procedure Minus (x : in Integer;
                    y : in Integer;
                    result : out Integer;
                    rpc_status : out StatusType) is
      specific_req : Method_Minus.Request.Specific_Data;
      specific_res : Method_Minus.Response.Specific_Data;
      req : Request.Request_Type;
      res : Response.Response_Type;
      procedure ConvertToRequest is new Request.ConvertToRequest(Method_Minus.Request.Specific_Data);
      procedure ConvertToSpecific is new Response.ConvertToSpecific(Method_Minus.Response.Specific_Data);

   begin
      specific_req.x := x;
      specific_req.y := y;
      ConvertToRequest(data => specific_req,
                       code => Method.METHOD_MINUS,
                       req => req);

      Channel.Send_Receive(req, res);

      rpc_status := Interface_Status.Code_To_Enum(res.Header.Status_Code);

      ConvertToSpecific(res, specific_res);

      -- Check if Data is valid
      if Method_Minus.Response.isValid(specific_res) then
         result := specific_res.result;
      else
         raise Invalid_Conversion_From_Response;
      end if;

   end Minus;


end Interface_Client;
