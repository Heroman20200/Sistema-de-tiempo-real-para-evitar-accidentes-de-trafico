package body Sensores is
   task body Cabeza is
      Interval         : Duration := 0.4;
      Retraso          : Time;
      PosicionCabeza   : HeadPosition_Samples_Type;
      Volante_actual   : Steering_Samples_Type;
      Volante_anterior : Steering_Samples_Type;
      Inclinado_X      : Boolean;
      Inclinado_Y      : Boolean;
      Sintoma_Cabeza   : Boolean;
   begin
      Retraso          := Big_Bang + To_Time_Span (Interval);
      Volante_anterior := 0;
      Inclinado_X      := False;
      Inclinado_Y      := False;
      Sintoma_Cabeza   := False;
      loop
         Starting_Notice ("Cabeza");

         -- Leer la posición de la cabeza usando HeadPosition
         Reading_HeadPosition (PosicionCabeza);
         Reading_Steering (Volante_actual);

         -- Comprobar si la cabeza está inclinada
         if (PosicionCabeza (x) > 30 or PosicionCabeza (x) < -30) then
            if (Inclinado_X) then
               if (not (Sintoma_Cabeza)) then
                  Sintomas.Set_Cabeza
                    (True); -- Marca la cabeza inclinada en el objeto protegido Síntomas
                  Sintoma_Cabeza := True;
               end if;
            else
               Inclinado_X := True;
            end if;

         else
            if (Inclinado_X) then
               Inclinado_X := False;
            end if;
         end if;

         if (PosicionCabeza (y) > 30 or PosicionCabeza (y) < -30) then
            if (Inclinado_Y) then
               if (not (Sintoma_Cabeza)) then
                  if
                    ((PosicionCabeza (y) > 30 and
                      (Volante_actual <= Volante_anterior)) or
                     (PosicionCabeza (y) < -30 and
                      ((Volante_actual >= Volante_anterior))))
                  then
                     Sintomas.Set_Cabeza (True);
                     Sintoma_Cabeza := True;
                  end if;
               end if;
            else
               Inclinado_Y := True;
            end if;

         else
            if (Inclinado_Y) then
               Inclinado_Y := False;
            end if;
         end if;

         if not (Inclinado_X) and not (Inclinado_Y) and Sintoma_Cabeza then
            Sintomas.Set_Cabeza (False);
            Sintoma_Cabeza := False;
         end if;

         Volante_anterior := Volante_actual; -- Retraso para la siguiente lectura

         Finishing_Notice ("Cabeza");
         delay until Retraso;
         Retraso := Retraso + To_Time_Span (Interval);
      end loop;
   end Cabeza;

   task body Distancia is
      Interval              : Duration;
      Retraso               : Time;
      Distance              : Distance_Samples_Type;
      Velocidad             : Speed_Samples_Type;
      Distance_Peligrosa    : Boolean;
      Distance_Imprudente   : Boolean;
      Distance_Insegura     : Boolean;
      Distancia_Recomendada : Distance_Samples_Type;
   begin
      Interval := 0.3;
      Retraso  := Big_Bang + To_Time_Span (Interval);
      loop
         Starting_Notice ("Distancia");
         Reading_Distance (Distance);
         Reading_Speed (Velocidad);

         Medidas.Set_Distancia (Distance);
         Medidas.Set_Velocidad (Velocidad);

         Distancia_Recomendada := (Distance_Samples_Type (Velocidad / 10)**2);

         if (Distance < Distancia_Recomendada / 3) then
            Sintomas.Set_Distancia_Insegura (False);
            Sintomas.Set_Distancia_Imprudente (False);
            Sintomas.Set_Distancia_Peligrosa (True);

         elsif (Distance < Distancia_Recomendada / 2) then
            Sintomas.Set_Distancia_Insegura (False);
            Sintomas.Set_Distancia_Imprudente (True);
            Sintomas.Set_Distancia_Peligrosa (False);

         elsif (Distance < Distancia_Recomendada) then
            Sintomas.Set_Distancia_Insegura (True);
            Sintomas.Set_Distancia_Imprudente (False);
            Sintomas.Set_Distancia_Peligrosa (False);
         else
            Sintomas.Set_Distancia_Insegura (False);
            Sintomas.Set_Distancia_Imprudente (False);
            Sintomas.Set_Distancia_Peligrosa (False);
         end if;

         Finishing_Notice ("Distancia");
         delay until Retraso;
         Retraso := Retraso + To_Time_Span (Interval);
      end loop;
   end Distancia;

   task body Volante is
      Interval         : Duration;
      Retraso          : Time;
      Volante_actual   : Steering_Samples_Type;
      Volante_anterior : Steering_Samples_Type;
      Vol              : Boolean;
   begin
      Interval         := 0.35;
      Retraso          := Big_Bang + To_Time_Span (Interval);
      Vol              := False;
      Volante_anterior := 0;
      loop
         Starting_Notice ("Volante");

         Reading_Steering (Volante_actual);
         if Vol then
            Vol := False;
            Sintomas.Set_Volantazo (False);
         end if;

         if
           (abs (Volante_actual - Volante_anterior) >= 20 and
            Medidas.Get_Velocidad > 40)
         then
            Sintomas.Set_Volantazo (True);
            Vol := True;
         end if;

         Volante_anterior := Volante_actual;

         Finishing_Notice ("Volante");
         delay until Retraso;
         Retraso := Retraso + To_Time_Span (Interval);
      end loop;
   end Volante;
end Sensores;
