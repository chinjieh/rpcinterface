with Interfaces;
with Ada.Strings.Bounded;

package Response is

   RESPONSE_SIZE : constant := 2048;
   HEADER_SIZE : constant := 256;
   BODY_SIZE : constant := RESPONSE_SIZE - HEADER_SIZE;

   subtype Status_Type is Interfaces.Unsigned_64;


   type Data_Type is new Interfaces.Unsigned_64;

   -- Header_Type is left as obvious types (not referencing other packages)
   -- for future ease of conversion to different languages
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
   procedure SetStatusCode(res : in out Response_Type ; c : in Status_Type);

      -- Converts a Response_DataType record into a Specific_Data record of methods
   generic
      type specific is private;
   procedure ConvertToSpecific(req : in Response_Type; data : out specific);

   generic
      type specific is private;
      procedure ConvertToResponse(data : in specific;
                               status : in Status_Type;
                               res : out Response_Type);

end Response;
