-- Angel Fernandez Duque y Miguel Angel Figuero Vallejo
-- Grupo CIM41-LAB-G15
-- Tareas: Cabeza, Distancia, Volante, Display y Riesgos || Objetos protegidos: Sintomas y Medidas.
--with Ada.Text_IO; use Ada.Text_IO;

with tools; use tools;

with Sensores;           use Sensores;
with Actuadores;         use Actuadores;
with Modo_Interrupcion;  use Modo_Interrupcion;
with Objetos_Protegidos; use Objetos_Protegidos;

package body add is
  Task_Cabeza    : Cabeza;
  Task_Distancia : Distancia;
  Task_Volante   : Volante;
  Task_Display   : Display;
  Task_Riesgos   : Riesgos;
  Task_Modo      : Modo;

  procedure Background is
  begin
    loop
      null;
    end loop;
  end Background;

begin
  Starting_Notice ("Programa Principal");
  Finishing_Notice ("Programa Principal");
end add;
