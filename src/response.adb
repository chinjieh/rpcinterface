with Ada.Unchecked_Conversion;
with Common;

package body Response is



   procedure SetStatusCode(res : in out Response_Type ; enum : in Interface_Status.StatusType) is
   begin
      res.Header.Status_Code := Interface_Status.Enum_To_Code(enum);
   end SetStatusCode;

   procedure ConvertToSpecific(res : in Response_Type; data : out specific) is

      Bits_Difference : Natural := Response.Data_Type'Size - specific'Size;

      type ByteArray is array(1..Bits_Difference/8) of Common.Byte;

      type PaddedData is
         record
            specificdata : specific;
            padding : ByteArray;
         end record;


      function Convert is new Ada.Unchecked_Conversion(Source => Response_DataType,
                                                       Target => PaddedData);

      padded : PaddedData;

   begin
      padded := Convert(res.Data);
      data := padded.specificdata;
      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;


   end ConvertToSpecific;


   procedure ConvertToResponse(data : in specific;
                               status : in Interface_Status.StatusType;
                               res : out Response_Type) is

      Bits_Difference : Natural := Response.Data_Type'Size - specific'Size;

      type ByteArray is array(1..Bits_Difference/8) of Common.Byte;

      type PaddedData is
         record
            specificdata : specific;
            padding : ByteArray;
         end record;

      function Convert is new Ada.Unchecked_Conversion(Source => PaddedData,
                                                       Target => Response_DataType);

      padding : ByteArray := (others => 0);
      padded : PaddedData;

   begin
      padded.specificdata := data;
      padded.padding := padding;
      res.Data := Convert(padded);
      Response.SetStatusCode(res => res,
                             enum => status);
      --if isValid(data) then
     --    Put_Line("Conversion To Specific succeeded.");
      --else
     --    Put_Line("Conversion To Specific failed.");
     -- end if;


   end ConvertToResponse;


end Response;
