with Kernel.Serial_Output; use Kernel.Serial_Output;
with devices;              use devices;
package Objetos_Protegidos is
   type M is (M1, M2, M3);
   protected Sintomas is
      procedure Set_Cabeza (Riesgo : in Boolean);
      function Get_Cabeza return Boolean;

      procedure Set_Distancia_Insegura (Insegura : in Boolean);
      function Get_Distancia_Insegura return Boolean;

      procedure Set_Distancia_Imprudente (Dist : in Boolean);
      function Get_Distancia_Imprudente return Boolean;

      procedure Set_Distancia_Peligrosa (Peligrosa : in Boolean);
      function Get_Distancia_Peligrosa return Boolean;

      procedure Set_Volantazo (Vol : in Boolean);
      function Get_Volantazo return Boolean;

   private
      Riesgo_Cabeza        : Boolean := False;
      Distancia_Insegura   : Boolean := False;
      Distancia_Imprudente : Boolean := False;
      Distancia_Peligrosa  : Boolean := False;
      Volantazo            : Boolean := False;
   end Sintomas;

   protected Medidas is
      procedure Set_Distancia (Dist : in Distance_Samples_Type);
      function Get_Distancia return Distance_Samples_Type;

      procedure Set_Velocidad (Vel : in Speed_Samples_Type);
      function Get_Velocidad return Speed_Samples_Type;

   private
      Distancia : Distance_Samples_Type;
      Velocidad : Speed_Samples_Type;
   end Medidas;

   protected Elegir_Modo is
      function getModo return M;
      procedure setModo (Modo : in M);

   private
      Modo_Actual : M := M1;
   end Elegir_Modo;

end Objetos_Protegidos;
