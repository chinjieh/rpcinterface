with Interfaces; use type Interfaces.Unsigned_64;

package body Interface_Status is

   function Enum_To_Code (enum : StatusType) return Code is
   begin

      case enum is

         when Rpc_Success => return 0;
         when Rpc_Invalid_Method_Code => return 1;
         when Rpc_Invalid_Conversion => return 2;
         when Rpc_Unknown_Status => return -1;

      end case;

   end Enum_To_Code;

   function Code_To_Enum (c : Code) return StatusType is
   begin

      case c is

         when 0 => return Rpc_Success;
         when 1 => return Rpc_Invalid_Method_Code;
         when 2 => return Rpc_Invalid_Conversion;
         when others => return Rpc_Unknown_Status;

      end case;

   end Code_To_Enum;



end Interface_Status;
