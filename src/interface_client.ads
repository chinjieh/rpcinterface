package Interface_Client is

   Invalid_Conversion_From_Response : exception;

   -- Initialisation of Interface, call at beginning
   procedure Init (addr : in String);

   type StatusType is (Rpc_Status_Success,
                       Rpc_Status_Invalid_Conversion,
                       Rpc_Status_Invalid_Method_Code,
                       Rpc_Status_Unknown_Status);

   -- Client Interface Methods --
   ------------------------------
   procedure Sum (x : in Integer;
                  y : in Integer; result : out Integer;
                  rpc_status : out StatusType);

   procedure Minus (x : in Integer;
                    y : in Integer;
                    result : out Integer;
                    rpc_status : out StatusType);

end Interface_Client;
