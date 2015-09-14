with Request;
package Method is

   subtype MethodCode is Request.MethodCodeType;

   -- Method Codes --
   METHOD_SUM : constant MethodCode := 1;
   METHOD_GETSPEED : constant MethodCode := 2;
   METHOD_MINUS : constant MethodCode := 3;


end Method;
