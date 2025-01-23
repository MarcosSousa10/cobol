       identification division.
       program-id. programIDName.

       environment division.
       configuration section.
      *colocar virgula 
       SPECIAL-NAMES.
           DECIMAL-POINT is COMMA.
       data division.
       working-storage section.
       77 wrk-nota1 pic 9(02)v99 value zeros.

       77 wrk-nota2 pic 9(02)v99 value zeros.

       77 wrk-media pic 9(02)v99 value zeros.
       procedure division.
       0100-RECEBE SECTION.
           display "digite a nota 1 "
           accept WRK-NOTA1.
           display "digite a nota 2"
           accept WRK-NOTA2.
       0150-PROCESSA SECTION.
           compute WRK-MEDIA = (WRK-NOTA1 + WRK-NOTA2) / 2.
       0200-MOSTRA SECTION.
           DISPLAY WRK-MEDIA.
      * GREATER MAIOR ////   THAN OR EQUAL  OU IGUAL A  7
           if WRK-MEDIA GREATER THAN OR EQUAL 7 
               display "APROVADO"
           else 
               IF WRK-MEDIA GREATER THAN OR EQUAL 2 
                   display "RECUPERACAO"
               ELSE
                   display "REPROVADO"
               END-IF
           END-IF.
       0300-final section.
           STOP RUN.

       end program programIDName.
