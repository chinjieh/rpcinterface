with Common;
with Ada.Strings.Bounded;
with Response;
package Status is

   subtype Code is Response.Status_Type;
   subtype MessageType is Response.MessageType;

   RPC_SUCCESS : constant Code := 0;
   RPC_INVALID_METHOD_CODE : constant Code := 1;
   RPC_INVALID_CONVERSION : constant Code := 2;

   type StatusObject is
      record
         Status : Code;
         Message : MessageType;
      end record;


   -- Instantiate StackHandler package to hold the status stack
   package Status_StackHandler is new Common.Generic_Stack(StatusObject);


   -- Gets the String form of the top status on stack and pops it off stack
   function GetLastStatus return String;

   -- Push a new StatusObject onto the stack
   procedure AddStatus (c : in Code ; msg : in MessageType := Response.MessageHandler.To_Bounded_String("Empty Message"));


   private
      Status_Stack : Status_StackHandler.Stack;
end Status;
