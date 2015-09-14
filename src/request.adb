with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;

package body Request is

   function getMethodCode (req: Request.Request_Type) return MethodCodeType is
   begin
      return req.Header.Method_Code;
   end getMethodCode;


   procedure ConvertToSpecific(req : in Request_Type; data : out specific) is

      function Convert is new Ada.Unchecked_Conversion(Source => Request_DataType,
                                                       Target => specific);

      converted : specific;
   begin
      converted := Convert(req.Data);


      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;

      data := converted;
   end ConvertToSpecific;


   procedure ConvertToRequest(data : in specific;
                              code : in MethodCodeType;
                              req : out Request_Type) is
      function Convert is new Ada.Unchecked_Conversion(Source => specific,
                                                       Target => Request_DataType);

      reqdata : Request_DataType;

   begin
      reqdata := Convert(data);
      req.Data := reqdata;
      req.Header.Method_Code := code;

      --TODO add checking here
      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;

   end ConvertToRequest;


end Request;
