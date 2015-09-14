
package body Method_Sum is

   package body Request is

      function isValid (data : Specific_Data) return Boolean is
      begin
         if data.x'Valid and data.y'Valid then
            return True;
         else
            return False;
         end if;
      end isValid;

   end Request;

   package body Response is

      function isValid(data : Specific_Data) return Boolean is
      begin
         if data.result'Valid then
            return True;
         else
            return False;
         end if;
      end isValid;

   end Response;


end Method_Sum;
