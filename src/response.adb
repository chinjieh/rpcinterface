with Ada.Unchecked_Conversion;

package body Response is



   procedure SetStatusCode(res : in out Response_Type ; c : in Status_Type) is
   begin
      res.Header.Status_Code := c;
   end SetStatusCode;

   procedure ConvertToSpecific(req : in Response_Type; data : out specific) is

      function Convert is new Ada.Unchecked_Conversion(Source => Response_DataType,
                                                       Target => specific);


   begin
      data := Convert(req.Data);
      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;


   end ConvertToSpecific;


   procedure ConvertToResponse(data : in specific;
                               status : in Status_Type;
                               res : out Response_Type) is
      function Convert is new Ada.Unchecked_Conversion(Source => specific,
                                                       Target => Response_DataType);


   begin
      res.Data := Convert(data);
      Response.SetStatusCode(res => res,
                             c => status);
      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;


   end ConvertToResponse;


end Response;
