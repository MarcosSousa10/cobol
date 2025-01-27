const http = require('http');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const port = 3000;

// Caminho absoluto do arquivo crud.dat
const filePath = path.join(__dirname, 'crud.dat');

// Função para executar o arquivo COBOL
const runCobolApi = (message) => {
  return new Promise((resolve, reject) => {
    console.log('Tentando executar o COBOL...');
    exec(`api.exe "${message}"`, (error, stdout, stderr) => {
      if (error) {
        reject(`Erro de execução: ${error.message}`);
      }
      if (stderr) {
        reject(`Erro de saída: ${stderr}`);
      }
      console.log('API COBOL executada com sucesso!');
      resolve(stdout);
    });
  });
};

// Função para ler o arquivo de mensagem
const readMessage = () => {
  return new Promise((resolve, reject) => {
    // Verifica se o arquivo existe
    fs.exists(filePath, (exists) => {
      if (!exists) {
        reject('Arquivo não encontrado');
        return;
      }

      // Lê o arquivo
      fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
          reject('Erro ao ler o arquivo');
        } else {
          resolve(data);
        }
      });
    });
  });
};

// Função para garantir que o arquivo seja criado com a mensagem
const createMessageFile = (message) => {
  return new Promise((resolve, reject) => {
    // Escreve a mensagem no arquivo
    fs.writeFile(filePath, message, 'utf8', (err) => {
      if (err) {
        reject('Erro ao criar o arquivo');
      } else {
        console.log(`Mensagem escrita no arquivo: ${message}`);  // Confirmação de escrita
        resolve('Arquivo criado com sucesso');
      }
    });
  });
};

// Criando o servidor HTTP
const server = http.createServer(async (req, res) => {
  // Endpoint para criar uma mensagem
  if (req.method === 'POST' && req.url === '/create') {
    let body = '';

    // Coleta os dados enviados no corpo da requisição
    req.on('data', chunk => {
      body += chunk;
    });

    req.on('end', async () => {
      try {
        // Cria o arquivo com a mensagem
        await createMessageFile(body);
        // Chama a função que executa o COBOL com a mensagem recebida
        const response = await runCobolApi(body);
        // Retorna o resultado para o cliente
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(`Mensagem criada com sucesso: ${response}`);
      } catch (error) {
        // Em caso de erro, retorna um erro 500
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end(error);  // Retorna o erro específico
      }
    });
  }
  // Endpoint para ler a mensagem
  else if (req.method === 'GET' && req.url === '/read') {
    try {
      const message = await readMessage();
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end(`Mensagem: ${message}`);
    } catch (error) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end(error);  // Exibe o erro específico (arquivo não encontrado ou erro de leitura)
    }
  } else {
    // Se a URL não for '/create' ou '/read', retorna um erro 404
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Endpoint não encontrado');
  }
});

// Inicia o servidor na porta configurada
server.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
