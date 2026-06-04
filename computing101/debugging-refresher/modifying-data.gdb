delete
break main
run

set $rip = main+574

break *main+633
commands
  silent
  set $rax = *(long*)($rbp-0x18)
  set $rdx = $rax
  set $rip = main+757
  continue
end

continue
