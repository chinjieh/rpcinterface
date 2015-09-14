with Ada.Strings.Bounded;
with Response;
package Status is

   subtype Code is Response.Status_Type;

   RPC_SUCCESS : constant Code := 0;
   RPC_INVALID_METHOD_CODE : constant Code := 1;
   RPC_INVALID_CONVERSION : constant Code := 2;

end Status;
