with Response;
with Method_Sum;
with Anet.Streams;
with Ada.Streams;
with Ada.Text_IO; use Ada.Text_IO;
with Common;
procedure Debug is

   res : Response.Response_Type;
   specific_res : Method_Sum_Response.Specific_Data;
   procedure ConvertToResponse is new Response.ConvertToResponse(Method_Sum_Response.Specific_Data);
   stream_res : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Response.RESPONSE_SIZE);
   Send_Data : Ada.Streams.Stream_Element_Array(1..16);
begin

   specific_res.result := 5;

   ConvertToResponse(specific_res, res.Data);
   res.Header.Method_Code := Common.Method_Code.SUM;

   -- Write data to Anet Stream Response
   Response.Response_Type'Write(stream_res'Access, res);

   -- Get raw buffer from Anet Stream Response and write to output buffer
   Put_Line("Size: " & Integer'Image(stream_res.Get_Buffer'Size/8));
   Send_Data := stream_res.Get_Buffer;

   --Get_Buffer returns size of Response record, in BITS.
   -- Divide 8 to get Bytes.
   -- Send_Data array has to match the size in bytes


end Debug;
