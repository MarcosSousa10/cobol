       identification division.
       program-id. programIDName.

       environment division.
       configuration section.
      *colocar virgula 
       SPECIAL-NAMES.
           DECIMAL-POINT is COMMA.
       data division.
       working-storage section.

      * X so com nome sem caractere X caractere 9 Numeros
       01 WRK-NOME1 PIC X(50) VALUE SPACES.
       77 WRK-IDADE PIC 999 VALUE ZEROS.
       77 WRK-valor1 PIC 9(05)v99 VALUE ZEROS.
       77 WRK-valor2 PIC 9(05)v99 VALUE ZEROS.
      * s para saber se e negativo ou positivo
       77 WRK-Resultado PIC s9(05)v99 VALUE ZEROS.
      *se tiver zz ignora as duas primeiras casass efor 0   - para valor
       77 WRK-Resultado2 PIC -zz.zz9,99 VALUE ZEROS.
       77 NOME-LEN PIC 99 VALUE ZEROS.
      *casas decimais v99
       77 WRK-SALARIO PIC 9(08)v99 VALUE ZEROS.
      * data
       77 WRK-DATA pic x(08) value spaces.
       01 WRK-DATA1.
           05 WRK-ANO pic x(04) value spaces.
           05 WRK-MES pic x(02) value spaces.
           05 WRK-DIA pic x(02) value spaces.

       01 WRK-DATA2.
           05 WRK-DIA pic x(02) value spaces.
           05 FILLER pic x(01) value "/".
           05 WRK-MES pic x(02) value spaces.
           05 FILLER pic x(01) value "/".
           05 WRK-ANO pic x(04) value spaces.
       procedure division.
       0100-RECEBE SECTION.
           DISPLAY "Digite seu nome: ".
           ACCEPT WRK-NOME1.

      * Verifica o comprimento do nome
           UNSTRING WRK-NOME1 DELIMITED BY SPACES INTO WRK-NOME1
           END-UNSTRING.
           
      * Exibe o nome e comprimento para depuração
           INSPECT WRK-NOME1 REPLACING ALL SPACES BY X'00'.
           DISPLAY "Nome digitado: " WRK-NOME1.
           DISPLAY "Comprimento do nome: " FUNCTION LENGTH(WRK-NOME1).

           DISPLAY "Digite sua idade: ".
           ACCEPT WRK-IDADE.
           display "Digite seu salario"
           accept WRK-SALARIO.
           display "valor 1: "
           accept WRK-VALOR1.
           display "digite o valor 2:"
           accept WRK-VALOR2.
           compute WRK-RESULTADO = WRK-VALOR1 - WRK-VALOR2.
      * mover o resultado para o 2 para colocar mascaras opcional
           move WRK-RESULTADO to WRK-RESULTADO2.
           accept WRK-DATA from date YYYYMMDD.
           accept WRK-DATA1 from date YYYYMMDD.
           move corr WRK-DATA1 to WRK-DATA2.
       0200-MOSTRA SECTION.
           DISPLAY "TESTE: " WRK-IDADE.
           DISPLAY "NOME e: " WRK-NOME1.
           display "salario digitado : " WRK-SALARIO.
           display "Resultado = " WRK-RESULTADO2.
           display "data de hoje e : " WRK-DATA.
           display "dia " WRK-DATA(07:02) " mes " WRK-DATA(05:02)
           " ano " WRK-DATA(1:4).
      *      display "dia " WRK-DIA " mes " WRK-MES" ano " WRK-ANO.
           display "dia " WRK-DIA of WRK-DATA2 " mes "
               WRK-MES of WRK-DATA2 " ano " WRK-ANO of WRK-DATA2.
           display WRK-DATA2.
       0300-final section.
           STOP RUN.

       end program programIDName.
