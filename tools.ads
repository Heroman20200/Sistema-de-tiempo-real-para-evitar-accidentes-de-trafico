with Ada.Real_Time; use Ada.Real_Time;
use type Ada.Real_Time.Time_Span;

with devices; use devices;

package tools is

    Big_Bang : constant Ada.Real_Time.Time := Clock;

    procedure Current_Time (Origen : Ada.Real_Time.Time);
    procedure Print_an_Integer (x : in Integer);
    procedure Print_a_Float (x : in Float);
    procedure Starting_Notice (T : in String);
    procedure Finishing_Notice (T : in String);
    procedure Execution_Time (Time : Ada.Real_Time.Time_Span);
    function Max (Beeping : Boolean; Num1, Num2 : Volume) return Volume;

end tools;
