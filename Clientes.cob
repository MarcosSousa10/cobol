       ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIENTES.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77 WRK-OPCAO PIC X(1).
       77 WRK-MODULO PIC X(20).
       77 WRK-TECLA PIC X(1).
       
       SCREEN SECTION.
       01 TELA.
           05 LIMPA-TELA.
               10 BLANK SCREEN.
               10 LINE 01 COLUMN 01 PIC X(20) ERASE EOL
                   BACKGROUND-COLOR 1.
               10 LINE 01 COLUMN 25 PIC X(20) FOREGROUND-COLOR 3
               FROM 'SISTEMA DE CLIENTES'.
               10 LINE 02 COLUMN 01 PIC X(25) ERASE EOL
                   BACKGROUND-COLOR 2 FROM WRK-MODULO.
       01 MENU.
           05 LINE 07 COLUMN 15 VALUE '1 - INCLUIR'.            
           05 LINE 08 COLUMN 15 VALUE '2 - CONSULTA'.            
           05 LINE 09 COLUMN 15 VALUE '3 - ALTERACAO'.            
           05 LINE 10 COLUMN 15 VALUE '4 - EXCLUSAO'.            
           05 LINE 11 COLUMN 15 VALUE '5 - RELATORIO'.            
           05 LINE 12 COLUMN 15 VALUE 'X - SAIR'.    
           05 LINE 13 COLUMN 15 VALUE 'OPCAO .........:' .     
           05 LINE 13 COLUMN 30 USING WRK-OPCAO.
       
       PROCEDURE DIVISION.
       0001-PRINCIPAL SECTION.
           PERFORM 1000-INICIAR
           PERFORM UNTIL WRK-OPCAO = 'X'
               PERFORM 2000-PROCESSAR
           END-PERFORM
           PERFORM 3000-FINALIZAR.
           STOP RUN.
           
       1000-INICIAR.
           MOVE SPACES TO WRK-MODULO.
           DISPLAY TELA.
           ACCEPT MENU.
           
       2000-PROCESSAR.
           EVALUATE WRK-OPCAO
               WHEN '1'
                   PERFORM 5000-INCLUIR
               WHEN '2'
                   MOVE 'MODULO - CONSULTA ' TO WRK-MODULO
                   DISPLAY TELA
                   ACCEPT WRK-TECLA
               WHEN '3'
                   MOVE 'MODULO - ALTERACAO ' TO WRK-MODULO
                   DISPLAY TELA
                   ACCEPT WRK-TECLA
               WHEN '4'
                   MOVE 'MODULO - EXCLUSAO ' TO WRK-MODULO
                   DISPLAY TELA
                   ACCEPT WRK-TECLA
               WHEN '5'
                   MOVE 'MODULO - RELATORIO ' TO WRK-MODULO
                   DISPLAY TELA
                   ACCEPT WRK-TECLA
               WHEN OTHER
                   IF WRK-OPCAO NOT EQUAL 'X'
                       DISPLAY "ENTRE COM UMA OPCAO CORRETA."
                   END-IF
           END-EVALUATE.
           
       3000-FINALIZAR.
           DISPLAY "ENCERRANDO O SISTEMA...".
           
       5000-INCLUIR.
           MOVE 'MODULO - INCLUSAO ' TO WRK-MODULO.
           DISPLAY TELA.
           ACCEPT WRK-TECLA.
