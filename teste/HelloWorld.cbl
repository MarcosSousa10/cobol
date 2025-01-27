       IDENTIFICATION DIVISION.
       PROGRAM-ID. HelloWorld.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CRUD-FILE ASSIGN TO 'C:\aulas\COBOLopen\CRUD.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CRUD-FILE.
       01  CRUD-RECORD.
           05  MESSAGE-TEXT    PIC X(100).

       WORKING-STORAGE SECTION.
       01  MSG-RETORNO       PIC X(100) VALUE "Mensagem da API COBOL!".
       01  USER-CHOICE       PIC 9.
       01  CRUD-RECORD-IN.
           05  MESSAGE-TEXT-IN  PIC X(100).

       PROCEDURE DIVISION.
       EXIBIR-MENSAGEM.
           DISPLAY MSG-RETORNO.
           STOP RUN.

       MAIN-PROGRAM.
           DISPLAY "Escolha uma opção:"
           DISPLAY "1 - Criar"
           DISPLAY "2 - Ler"
           DISPLAY "3 - Atualizar"
           DISPLAY "4 - Excluir"
           ACCEPT USER-CHOICE

           EVALUATE USER-CHOICE
               WHEN 1
                   PERFORM CREATE-RECORD
               WHEN 2
                   PERFORM READ-RECORD
               WHEN 3
                   PERFORM UPDATE-RECORD
               WHEN 4
                   PERFORM DELETE-RECORD
               WHEN OTHER
                   DISPLAY "Opção inválida."
           END-EVALUATE

           STOP RUN.

       CREATE-RECORD.
           DISPLAY "Digite a mensagem para criar:"
           ACCEPT MESSAGE-TEXT-IN
           OPEN OUTPUT CRUD-FILE
           MOVE MESSAGE-TEXT-IN TO MESSAGE-TEXT
           WRITE CRUD-RECORD
           CLOSE CRUD-FILE
           DISPLAY "Mensagem criada com sucesso.".

       READ-RECORD.
           OPEN INPUT CRUD-FILE
           READ CRUD-FILE INTO CRUD-RECORD
           AT END
               DISPLAY "Nenhuma mensagem encontrada."
           NOT AT END
               DISPLAY "Mensagem encontrada: " MESSAGE-TEXT
           CLOSE CRUD-FILE.

       UPDATE-RECORD.
           DISPLAY "Digite a nova mensagem:"
           ACCEPT MESSAGE-TEXT-IN
           OPEN I-O CRUD-FILE
           READ CRUD-FILE INTO CRUD-RECORD
           AT END
               DISPLAY "Mensagem não encontrada."
               CLOSE CRUD-FILE
               EXIT
           NOT AT END
               MOVE MESSAGE-TEXT-IN TO MESSAGE-TEXT
               REWRITE CRUD-RECORD
               DISPLAY "Mensagem atualizada."
           CLOSE CRUD-FILE.



       DELETE-RECORD.
           DISPLAY "Excluir mensagem? (S/N)"
           ACCEPT USER-CHOICE
           IF USER-CHOICE = 'S' OR USER-CHOICE = 's'
               OPEN I-O CRUD-FILE
               READ CRUD-FILE INTO CRUD-RECORD
               DELETE CRUD-FILE
               CLOSE CRUD-FILE
               DISPLAY "Mensagem excluída."
           ELSE
               DISPLAY "Exclusão cancelada."
           END-IF.
