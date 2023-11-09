package body Modo_Interrupcion is
    protected body Interrupt_Handler is
        procedure Interrupcion is
        begin
            Llamada_Pendiente := True;
        end Interrupcion;

        entry Esperar_Evento when Llamada_Pendiente is
        begin
            Llamada_Pendiente := False;
            -- Restablecer la llamada pendiente
        end Esperar_Evento;
    end Interrupt_Handler;

    task body Modo is
    begin
        loop
            Starting_Notice ("Modo");
            Interrupt_Handler
               .Esperar_Evento; -- Esperar la llamada de interrupción
            case Elegir_Modo.getModo is
                when M1 =>
                    if not Sintomas.Get_Distancia_Peligrosa then
                        New_Line;
                        Put_Line ("Cambiando al modo M2");
                        Elegir_Modo.setModo (M2);
                    end if;
                when M2 =>
                    if not Sintomas.Get_Distancia_Peligrosa and not Sintomas.Get_Cabeza
                    then
                        New_Line;
                        Put_Line ("Cambiando al modo M3");
                        Elegir_Modo.setModo (M3);
                    end if;
                when M3 =>
                    New_Line;
                    Put_Line ("Cambiando al modo M1");
                    Elegir_Modo.setModo (M1);
            end case;
            Finishing_Notice ("Modo");
        end loop;
    end Modo;

end Modo_Interrupcion;
