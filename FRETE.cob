       identification division.
       program-id. programIDName.

       environment division.
       configuration section.
      *colocar virgula 
       SPECIAL-NAMES.
           DECIMAL-POINT is COMMA.
       data division.
       working-storage section.
       77 wrk-produto pic x(30) value spaces.
       77 wrk-estado pic x(02) value spaces.
       77 wrk-valor pic 9(08)v99 value zeros.
       77 wrk-frete pic 9(08)v99 value zeros.
       
       77 wrk-valor-ED pic -zzzzzzzzzz9,99 value zeros.
       77 wrk-frete-ED pic -zzzzzzzzzz9,99 value zeros.

       procedure division.
       0100-RECEBE SECTION.
           display "Produto"
           accept WRK-PRODUTO .
           display "valor"
           accept WRK-VALOR.
           display "estado"
           accept wrk-estado.
       0150-PROCESSA SECTION.
           if WRK-ESTADO EQUAL "SP"
               compute WRK-FRETE = (WRK-VALOR * 0,10)
      *        compute WRK-VALOR = WRK-VALOR + WRK-FRETE
      *        add WRK-FRETE to WRK-VALOR
           END-IF.
           if WRK-ESTADO EQUAL "RJ"
               compute WRK-FRETE = (WRK-VALOR * 0,15)
           END-IF.
               if WRK-ESTADO EQUAL "ES"
               compute WRK-FRETE = (WRK-VALOR * 0,20)
           END-IF.
           COMPUTE WRK-VALOR = WRK-VALOR + WRK-FRETE.
           MOVE WRK-VALOR to WRK-VALOR-ED
           MOVE WRK-FRETE to WRK-FRETE-ED.
       0200-MOSTRA SECTION.
           display WRK-VALOR-ED .
           display WRK-FRETE-ED .

       0300-final section.
           STOP RUN.

       end program programIDName.
