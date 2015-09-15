with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;

package body Request is

   function getMethodCode (req: Request.Request_Type) return MethodCodeType is
   begin
      return req.Header.Method_Code;
   end getMethodCode;


   procedure ConvertToSpecific(req : in Request_Type; data : out specific) is

      Bits_Difference : Natural := Request_DataType'Size - specific'Size;

      type ByteArray is array(1..Bits_Difference/8) of Common.Byte;

      type PaddedData is
         record
            specificdata : specific;
            padding : ByteArray;
         end record;


      function Convert is new Ada.Unchecked_Conversion(Source => Request_DataType,
                                                       Target => PaddedData);

      padded : PaddedData;
   begin
      padded := Convert(req.Data);
      data := padded.specificdata;

   end ConvertToSpecific;


   procedure ConvertToRequest(data : in specific;
                              code : in MethodCodeType;
                              req : out Request_Type) is

      Bits_Difference : Natural := Request_DataType'Size - specific'Size;

      type ByteArray is array (1..Bits_Difference/8) of Common.Byte;

      -- Padded Record to contain specific data, with the padded Bytes to match
      -- size of Request_Data
      type PaddedData is
         record
            specificdata : specific;
            padding : ByteArray;
         end record;


      function Convert is new Ada.Unchecked_Conversion(Source => PaddedData,
                                                       Target => Request_DataType);

      reqdata : Request_DataType;
      padded : PaddedData;
      padding : ByteArray := (others => 0);
   begin
      padded.specificdata := data;
      padded.padding := padding;
      reqdata := Convert(padded);
      req.Data := reqdata;
      req.Header.Method_Code := code;

   end ConvertToRequest;


end Request;
