with Channel_Client;
with Request;
with Ada.Unchecked_Conversion;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test is

   type UnconstrainedRecord is
      record
         x : Integer;
      end record;

   type ConstrainedRecord is
      record
         x : Integer range 0..5;
      end record;

   type GenericRecord is
      record
         data : Integer;
      end record;


   function UnconstrainedToGeneric is new Ada.Unchecked_Conversion(Source=>UnconstrainedRecord,
                                                                   Target=>GenericRecord);

   function GenericToConstrained is new Ada.Unchecked_Conversion(Source=>GenericRecord,
                                                                 Target=>ConstrainedRecord);

   beforeconvert : UnconstrainedRecord;
   afterconvert : ConstrainedRecord;
   midconvert : GenericRecord;

begin

   beforeconvert.x := 10;
   midconvert := UnconstrainedToGeneric(beforeconvert);
   afterconvert := GenericToConstrained(midconvert);

   Put_Line("Conversion is: " & Boolean'Image(afterconvert.x'Valid));
   Put_Line("After conversion: " & Integer'Image(afterconvert.x));



end Test;
