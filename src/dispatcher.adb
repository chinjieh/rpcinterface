with Request;
with Response;
with Method;
with Status;
with DispatchHandler;
with Ada.Text_IO; use Ada.Text_IO;

package body Dispatcher is

   procedure Dispatch(req : in Request.Request_Type; res : out Response.Response_Type) is

   begin

      Put_Line("Dispatcher: Received Request with method code: " & Method.MethodCode'Image(Request.getMethodCode(req)));

      case Request.getMethodCode(req) is
         when Method.METHOD_SUM =>
            DispatchHandler.Handle_Sum(req, res);
         when Method.METHOD_MINUS =>
            DispatchHandler.Handle_Minus(req, res);
         when others =>
            -- Create Response with Error
            Response.SetStatusCode(res, Status.RPC_INVALID_METHOD_CODE);
            Response.SetStatusMessage(res, "Invalid Method Code found: " &
                                        Request.MethodCodeType'Image(Request.getMethodCode(req)));

      end case;



   end Dispatch;


end Dispatcher;