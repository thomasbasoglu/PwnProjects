break main
run

# Skip the int3 trap
set $rip = main+739

# Before scanf: copy file value to the input variable directly, then skip scanf
break *main+833
commands
  silent
  # [rbp-0x18] has the file value, [rbp-0x10] is where scanf would write
  # Copy file value directly to the input slot
  set {long}($rbp-0x10) = *(long*)($rbp-0x18)
  # Skip past the scanf call to main+860
  set $rip = main+860
  continue
end

continue
