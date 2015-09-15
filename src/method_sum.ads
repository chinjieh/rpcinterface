with Request;
with Response;
package Method_Sum is

   package Request is

      type Specific_Data is
         record
            x : Integer;
            y : Integer;
         end record;
      --for Specific_Data'Size use Standard.Request.BODY_SIZE * 8;

      function isValid(data : Specific_Data) return Boolean;

   end Request;


   package Response is

      type Specific_Data is
      record
         result : Integer;
         end record;

      for Specific_Data'Size use Standard.Response.BODY_SIZE * 8;

      function isValid(data : Specific_Data) return Boolean;

   end Response;



end Method_Sum;
