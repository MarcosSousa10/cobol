       identification division.
       program-id. programIDName.

       environment division.
       configuration section.
      *colocar virgula 
       SPECIAL-NAMES.
           DECIMAL-POINT is COMMA.
       data division.
       working-storage section.
       01 wrk-entrada.
           05 wrk-codigo pic 9(04) value zeros.
           05 wrk-nome pic x(15) value spaces.
           05 wrk-salario pic 9(06) value zeros.      
       01 wrk-dados.
           05 wrk-num1 pic 9(3) value zeros.
           05 wrk-num2 pic 9(3) value zeros.
       77 wrk-result pic 9(5) value zeros.


       77 wrk-nume1 pic 9(04) value zeros.
       77 wrk-nume2 pic 9(04) value zeros.
       77 wrk-resultado pic s9(07)v99 value 1.
       77 wrk-resultado2 pic 9(07) value 1.
       77 wrk-resultado2-ed pic -z.zzz.zz9,99 value zeros.

       procedure division.
       0100-RECEBE SECTION.
           display "entre com a linha de dados :".
      *    accept wrk-entrada . 
      *0001SILVIO SANTOS  500000
      *............................................
      *    accept wrk-dados.
      *    compute WRK-RESULT = WRK-NUM1 + WRK-NUM2.
      *..............................................
           accept WRK-NUME1.
           accept WRK-NUME2.
      * soma tudo comtando com defalut 
      *        add WRK-NUME1 WRK-NUME2 to WRK-RESULTADO.
      * zera o dagalt e soma o restante
      *        add WRK-NUME1 WRK-NUME2 GIVING WRK-RESULTADO.
      *        move WRK-RESULTADO to WRK-RESULTADO2.
      * tambem da para usar assuim 
      *    add WRK-NUME1 WRK-NUME2 to WRK-RESULTADO WRK-RESULTADO2.
      *subtrair
      *    SUBTRACT WRK-NUME1 from WRK-NUME2 giving WRK-RESULTADO.
      * multiplicação
      *    MULTIPLY WRK-NUME1 by WRK-NUME2 GIVING WRK-RESULTADO.
      *    move WRK-RESULTADO to WRK-RESULTADO2-ED.
      * divisão
      *tratativa de error na logica
      *    DIVIDE WRK-NUME1 by WRK-NUME2 GIVING WRK-RESULTADO
      *        on SIZE error
      *            display "erro - divisao por  0".
      *soma tudo
      *    add WRK-NUME1 WRK-NUME2 GIVING WRK-RESULTADO
      *    divide WRK-RESULTADO by 2 GIVING WRK-RESULTADO.
      *ou
           compute WRK-RESULTADO = (WRK-NUME1 + WRK-NUME2 )/ 2 .

       0200-MOSTRA SECTION.
           display "codigo... " WRK-CODIGO.
           display "nome... " WRK-NOME.
           display "salario... " WRK-SALARIO.
           display WRK-RESULT.
           display WRK-RESULTADO.
           display wrk-resultado2-ed.
       0300-final section.
           STOP RUN.

       end program programIDName.
