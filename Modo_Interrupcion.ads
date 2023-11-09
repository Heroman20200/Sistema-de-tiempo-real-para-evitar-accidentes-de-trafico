with Kernel.Serial_Output; use Kernel.Serial_Output;
with Ada.Interrupts.Names;

with tools;           use tools;
with pulse_interrupt; use pulse_interrupt;

with Objetos_Protegidos; use Objetos_Protegidos;

package Modo_Interrupcion is
    protected Interrupt_Handler is
        pragma Priority (Priority_Of_External_Interrupts_2);
        procedure Interrupcion;
        pragma Attach_Handler
           (Interrupcion, Ada.Interrupts.Names.External_Interrupt_2);

        entry Esperar_Evento;

    private
        Llamada_Pendiente : Boolean := False;
    end Interrupt_Handler;

    task type Modo is
        pragma Priority (15);
    end Modo;

end Modo_Interrupcion;
