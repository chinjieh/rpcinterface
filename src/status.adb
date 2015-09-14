
package body Status is

   function GetLastStatus return String is
      obj : StatusObject;
   begin

      Status_StackHandler.Pop(obj, Status_Stack);

      return Response.MessageHandler.To_String(obj.Message);

   exception
      when Status_StackHandler.Stack_Empty_Error =>
         return "No status message found to report.";
   end GetLastStatus;


   procedure AddStatus (c : in Code ; msg : in MessageType := Response.MessageHandler.To_Bounded_String("Empty Message")) is
      obj : StatusObject;
   begin
      obj.Status := c;
      obj.Message := msg;

      Status_StackHandler.Push(obj, Status_Stack);

   end AddStatus;


end Status;
