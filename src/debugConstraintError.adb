with Response;
with Method_Sum_Response;
with Anet.Streams;
procedure DebugConstraintError is

   res : Response.Response_Type;
   specific_res : Method_Sum_Response.Specific_Data;
   procedure ConvertToResponse is new Response.ConvertToResponse(Method_Sum_Response.Specific_Data);
   stream_res : aliased Anet.Streams.Memory_Stream_Type(Max_Elements => Response.RESPONSE_SIZE);
   Send_Data : Ada.Streams.Stream_Element_Array;
begin

   specific_res.result := 5;

   ConvertToResponse(specific_res, res.Data);
   res.Header.Method_Id := 00000001;

   -- Write data to Anet Stream Response
   Response.Response_Type'Write(stream_res'Access, res);

   -- Get raw buffer from Anet Stream Response and write to output buffer
   Send_Data := stream_res.Get_Buffer;


end DebugConstraintError;
