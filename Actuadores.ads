with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time;        use Ada.Real_Time;

with tools;   use tools;
with devices; use devices;

with Objetos_Protegidos; use Objetos_Protegidos;
package Actuadores is
   task type Display is
      pragma Priority (10);
   end Display;

   task type Riesgos is
      pragma Priority (13);
   end Riesgos;
end Actuadores;
