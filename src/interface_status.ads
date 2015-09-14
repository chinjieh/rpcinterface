with Interfaces;
package Interface_Status is

   subtype Code is Interfaces.Unsigned_64;

   type StatusType is (Rpc_Success,
                       Rpc_Invalid_Method_Code,
                       Rpc_Invalid_Conversion,
                       Rpc_Unknown_Status);

   function Enum_To_Code (enum : StatusType) return Code;

   function Code_To_Enum (c : Code) return StatusType;

end Interface_Status;
