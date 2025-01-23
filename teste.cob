       identification division.
       program-id. programIDName.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 WRK-NOME1 PIC X(50) VALUE SPACES.
       77 WRK-IDADE PIC 99 VALUE ZEROS.
       77 NOME-LEN PIC 99 VALUE ZEROS.

       procedure division.

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

           DISPLAY "TESTE: " WRK-IDADE.
           DISPLAY "NOME É: " WRK-NOME1.

           STOP RUN.

       end program programIDName.
