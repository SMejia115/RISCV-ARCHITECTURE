# Instrucciones de ejecución Monocycle

Ejecuta lo siguiente en la línea de comandos:

~~~
$ cd MONOCYCLE
$ iverilog -g2012 -o monocycle monocycle_tb.sv monocycle.sv
$ vvp monocycle
~~~

Esto compilará la arquitectura y el testbench del procesador monocycle RISCV de 32 bits.