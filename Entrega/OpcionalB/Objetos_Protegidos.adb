package body Objetos_Protegidos is
   protected body Sintomas is
      function Get_Cabeza return Boolean is
      begin
         return Riesgo_Cabeza;
      end Get_Cabeza;

      procedure Set_Cabeza (Riesgo : in Boolean) is
      begin
         Riesgo_Cabeza := Riesgo;
      end Set_Cabeza;

      function Get_Distancia_Insegura return Boolean is
      begin
         return Distancia_Insegura;
      end Get_Distancia_Insegura;

      procedure Set_Distancia_Insegura (Insegura : in Boolean) is
      begin
         Distancia_Insegura := Insegura;
      end Set_Distancia_Insegura;

      function Get_Distancia_Imprudente return Boolean is
      begin
         return Distancia_Imprudente;
      end Get_Distancia_Imprudente;

      procedure Set_Distancia_Imprudente (Dist : in Boolean) is
      begin
         Distancia_Imprudente := Dist;
      end Set_Distancia_Imprudente;

      function Get_Distancia_Peligrosa return Boolean is
      begin
         return Distancia_Peligrosa;
      end Get_Distancia_Peligrosa;

      procedure Set_Distancia_Peligrosa (Peligrosa : in Boolean) is
      begin
         Distancia_Peligrosa := Peligrosa;
      end Set_Distancia_Peligrosa;

      function Get_Volantazo return Boolean is
      begin
         return Volantazo;
      end Get_Volantazo;

      procedure Set_Volantazo (Vol : in Boolean) is
      begin
         Volantazo := Vol;
      end Set_Volantazo;
   end Sintomas;

   protected body Medidas is
      function Get_Distancia return Distance_Samples_Type is
      begin
         return Distancia;
      end Get_Distancia;

      procedure Set_Distancia (Dist : in Distance_Samples_Type) is
      begin
         Distancia := Dist;
      end Set_Distancia;

      function Get_Velocidad return Speed_Samples_Type is
      begin
         return Velocidad;
      end Get_Velocidad;

      procedure Set_Velocidad (Vel : in Speed_Samples_Type) is
      begin
         Velocidad := Vel;
      end Set_Velocidad;
   end Medidas;

   protected body Elegir_Modo is
      function getModo return M is
      begin
         return Modo_Actual;
      end getModo;

      procedure setModo (Modo : in M) is
      begin
         Modo_Actual := Modo;
      end setModo;
   end Elegir_Modo;
end Objetos_Protegidos;
