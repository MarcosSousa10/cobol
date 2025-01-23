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
           evaluate WRK-ESTADO
            when 'SP'
                compute WRK-FRETE = WRK-VALOR * 0,10
            when 'RJ'
                compute WRK-FRETE = WRK-VALOR * 0,15
           when 'ES'
                compute WRK-FRETE = WRK-VALOR * 0,20
           WHEN OTHER 
               display "não entregamos nesse estado" WRK-ESTADO
           end-evaluate.
           compute WRK-VALOR = WRK-VALOR + WRK-FRETE
           move WRK-VALOR to WRK-VALOR-ED
               move WRK-FRETE to WRK-FRETE-ED.
           
       0200-MOSTRA SECTION.
           display WRK-VALOR .
           if WRK-FRETE GREATER 0
               display WRK-FRETE 
           END-IF.
       0300-final section.
           STOP RUN.

       end program programIDName.
