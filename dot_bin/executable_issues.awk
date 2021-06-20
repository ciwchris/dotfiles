#! /bin/awk -f


{
# https://www.tutorialspoint.com/awk/index.htm
# reading and closing: http://www.gnu.org/software/gawk/manual/html_node/Close-Files-And-Pipes.html#Close-Files-And-Pipes
# http://www.gnu.org/software/gawk/manual/html_node/Two_002dway-I_002fO.html#Two_002dway-I_002fO
# https://www.gnu.org/software/gawk/manual/html_node/Bracket-Expressions.html

    if ($2 == "open") {
       cmd = "git bug show " $1
       i = 0
       while ((cmd | getline result) > 0) {
           a[i] = result
           i++
           if (result ~ "^labels:.*(\\s|,)" label "(,|$)") {
               print a[0]
               next
           }
       }
       close(cmd)
    }
}


