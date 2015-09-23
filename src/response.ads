with Interfaces;
with Interface_Status;
with Common;

package Response is

   subtype Status_Type is Interface_Status.Code;

   -- Sizes in Bytes --
   RESPONSE_SIZE : constant := 2048;
   HEADER_SIZE : constant := Status_Type'Size/8;
   BODY_SIZE : constant := RESPONSE_SIZE - HEADER_SIZE;


   type Data_Type is array (1..BODY_SIZE) of Common.Byte;

   type Header_Type is
      record
         Status_Code : Status_Type;
      end record;
   for Header_Type'Size use HEADER_SIZE * 8;

   type Response_DataType is
      record
         Data :  Data_Type;
      end record;
   for Response_DataType'Size use BODY_SIZE * 8;

   type Response_Type is
      record
         Header : Header_Type;
         Data : Response_DataType;
      end record;

   for Response_Type use
      record
         Header at 0 range 0 .. (HEADER_SIZE * 8) -1;
         Data at Header_Size range 0 .. (BODY_SIZE * 8) - 1;
      end record;
   for Response_Type'Size use RESPONSE_SIZE * 8;


   -- Set Status Code
   procedure SetStatusCode(res : in out Response_Type ; enum : in Interface_Status.StatusType);

   -- Converts a Response_Type record into a Specific_Data record of methods
   generic
      type specific is private;
   procedure ConvertToSpecific(res : in Response_Type; data : out specific);

   -- Converts a Specific Data type into a Response_Type with status code
   generic
      type specific is private;
      procedure ConvertToResponse(data : in specific;
                               status : in Interface_Status.StatusType;
                               res : out Response_Type);

end Response;
