with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Real_Time;        use Ada.Real_Time;

with devices; use devices;
with tools;   use tools;

with Objetos_Protegidos; use Objetos_Protegidos;

package Sensores is
   task type Cabeza is
      pragma Priority (14);
   end Cabeza;

   task type Distancia is
      pragma Priority (12);
   end Distancia;

   task type Volante is
      pragma Priority (11);
   end Volante;
end Sensores;
