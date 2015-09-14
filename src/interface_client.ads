with Interface_Status;

package Interface_Client is

   Invalid_Conversion_From_Response : exception;

   -- Initialisation of Interface, call at beginning
   procedure Init (addr : in String);

   subtype StatusType is Interface_Status.StatusType;


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
