package body Actuadores is
   task body Display is
      Interval : Duration;
      Retraso  : Time;
   begin
      Interval := 1.0;
      Retraso  := Big_Bang + To_Time_Span (Interval);
      loop
         Starting_Notice ("Display");
         Display_Distance (Medidas.Get_Distancia);
         Display_Speed (Medidas.Get_Velocidad);

         if Sintomas.Get_Cabeza then
            New_Line;
            Put_Line ("............#¡Cuidado, tienes la cabeza inclinada!");
         end if;

         if Elegir_Modo.getModo /= M2 then
            if Sintomas.Get_Distancia_Insegura then
               New_Line;
               Put_Line ("............#Distancia insegura!!!");
            end if;

            if Sintomas.Get_Distancia_Imprudente then
               New_Line;
               Put_Line ("............#Distancia Imprudente!!!");
            end if;
         end if;

         if Sintomas.Get_Distancia_Peligrosa then
            New_Line;
            Put_Line ("Distancia peligrosa!!!");
         end if;

         if Sintomas.Get_Volantazo then
            New_Line;
            Put_Line ("¡Cuidado, has pegado un Volantazo!!!");
         end if;

         Finishing_Notice ("Display");
         delay until Retraso;
         Retraso := Retraso + To_Time_Span (Interval);
      end loop;
   end Display;

   task body Riesgos is
      Interval             : Duration;
      Retraso              : Time;
      Velocidad            : Speed_Samples_Type;
      Intensity            : Volume;
      Beeping              : Boolean;
      Cabeza_Inclinada              : Boolean;
      Distancia_Insegura   : Boolean;
      Distancia_Imprudente : Boolean;
      Distancia_Peligrosa  : Boolean;
      Luz_Encendida        : Boolean;
   begin
      Interval      := 0.15;
      Retraso       := Big_Bang + To_Time_Span (Interval);
      Beeping       := False;
      Luz_Encendida := False;
      loop
         if Elegir_Modo.getModo /= M3 then
            Starting_Notice ("Riesgos");

            Velocidad            := Medidas.Get_Velocidad;
            Cabeza_Inclinada              := Sintomas.Get_Cabeza;
            Distancia_Insegura   := Sintomas.Get_Distancia_Insegura;
            Distancia_Imprudente := Sintomas.Get_Distancia_Imprudente;
            Distancia_Peligrosa  := Sintomas.Get_Distancia_Peligrosa;

            if Sintomas.Get_Volantazo and not Cabeza_Inclinada and
              not Distancia_Insegura and not Distancia_Imprudente and
              not Distancia_Peligrosa
            then
               Intensity := Max (Beeping, Intensity, 1);
               Beeping   := True;
            end if;

            if Cabeza_Inclinada then
               if Velocidad < 70 then
                  Intensity := Max (Beeping, Intensity, 2);
                  Beeping   := True;
               else
                  Intensity := Max (Beeping, Intensity, 3);
                  Beeping   := True;
               end if;

               if Distancia_Peligrosa then
                  Intensity := Max (Beeping, Intensity, 5);
                  Beeping   := True;
                  Activate_Brake;
               end if;

            end if;

            if Elegir_Modo.getModo /= M2 then
               if Distancia_Insegura or Distancia_Imprudente then
                  if Distancia_Insegura then
                     if not Luz_Encendida then
                        Light (On);
                        Luz_Encendida := True;
                     end if;

                  else
                     Intensity := Max (Beeping, Intensity, 4);
                     Beeping   := True;
                     if not Luz_Encendida then
                        Light (On);
                        Luz_Encendida := True;
                     end if;
                  end if;
               else
                  if Luz_Encendida then
                     Light (Off);
                     Luz_Encendida := False;
                  end if;
               end if;
            else
               if Luz_Encendida then
                  Light (Off);
                  Luz_Encendida := False;
               end if;
            end if;

            if Beeping then
               Beep (Intensity);
               Beeping := False;
            end if;

            Finishing_Notice ("Riesgos");
         end if;
         delay until Retraso;
         Retraso := Retraso + To_Time_Span (Interval);
      end loop;
   end Riesgos;
end Actuadores;
