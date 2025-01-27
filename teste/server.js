const http = require('http');
const { exec } = require('child_process');
const port = 3000;

const runCobolApi = () => {
  return new Promise((resolve, reject) => {
    console.log('Tentando executar o COBOL...');
    exec('api.exe', (error, stdout, stderr) => {
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

  

// Criando o servidor HTTP
const server = http.createServer(async (req, res) => {
  if (req.method === 'GET' && req.url === '/api') {
    try {
      const response = await runCobolApi();
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end(response);
    } catch (error) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Erro na execução da API COBOL');
    }
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Endpoint não encontrado');
  }
});

server.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
