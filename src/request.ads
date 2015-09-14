with Interfaces;
with Common;

package Request is

   REQUEST_SIZE : constant := 2048;
   HEADER_SIZE : constant := 8;
   BODY_SIZE : constant := REQUEST_SIZE - HEADER_SIZE;

   type MethodCodeType is new Interfaces.Unsigned_64;
   type Data_Type is new Interfaces.Unsigned_64;

   type Header_Type is
      record
         Method_Code : MethodCodeType;
      end record;
   for Header_Type'Size use HEADER_SIZE * 8;

   type Request_DataType is
      record
         Data :  Data_Type;
      end record;
   for Request_DataType'Size use BODY_SIZE * 8;


   type Request_Type is
      record
         Header : Header_Type;
         Data : Request_DataType;
      end record;

   for Request_Type use
      record
         Header at 0 range 0 .. (HEADER_SIZE * 8) -1;
         Data at Header_Size range 0 .. (BODY_SIZE * 8) - 1;
      end record;
   for Request_Type'Size use REQUEST_SIZE * 8;


   -- Gets the unique method identifier
   function getMethodCode (req: Request.Request_Type) return MethodCodeType;

   -- Converts a Request_DataType record into a Specific_Data record of methods
   generic
      type specific is private;
   procedure ConvertToSpecific(req : in Request_Type; data : out specific);

   generic
      type specific is private;
   procedure ConvertToRequest(data : in specific;
                              code : in MethodCodeType;
                              req : out Request_Type);


end Request;
