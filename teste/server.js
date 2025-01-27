const http = require('http');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const port = 3000;

// Caminho absoluto do arquivo CRUD
const filePath = path.join(__dirname, 'crud.json');

// Função para executar a API COBOL
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

// Função para ler as mensagens do arquivo
const readMessages = () => {
  return new Promise((resolve, reject) => {
    fs.exists(filePath, (exists) => {
      if (!exists) {
        resolve([]); // Retorna um array vazio se o arquivo não existir
        return;
      }

      fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
          reject('Erro ao ler o arquivo');
        } else {
          try {
            resolve(JSON.parse(data)); // Converte o conteúdo para um array de objetos
          } catch (e) {
            reject('Erro ao analisar os dados');
          }
        }
      });
    });
  });
};

// Função para salvar as mensagens no arquivo
const saveMessages = (messages) => {
  return new Promise((resolve, reject) => {
    fs.writeFile(filePath, JSON.stringify(messages, null, 2), 'utf8', (err) => {
      if (err) {
        reject('Erro ao salvar mensagens');
      } else {
        resolve('Mensagens salvas com sucesso');
      }
    });
  });
};

// Criando o servidor HTTP
const server = http.createServer(async (req, res) => {
  // Endpoint para criar uma nova mensagem
  if (req.method === 'POST' && req.url === '/create') {
    let body = '';

    req.on('data', chunk => {
      body += chunk;
    });

    req.on('end', async () => {
      try {
        const messages = await readMessages(); // Lê as mensagens existentes
        const newMessage = { id: Date.now(), message: body }; // Cria uma nova mensagem com ID único
        messages.push(newMessage); // Adiciona a nova mensagem
        await saveMessages(messages); // Salva as mensagens atualizadas
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ message: 'Mensagem criada com sucesso', data: newMessage }));
      } catch (error) {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: error.message }));
      }
    });
  }
  // Endpoint para ler todas as mensagens
  else if (req.method === 'GET' && req.url === '/read') {
    try {
      const messages = await readMessages();
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ messages }));
    } catch (error) {
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: error.message }));
    }
  }
  // Endpoint para atualizar uma mensagem
  else if (req.method === 'PUT' && req.url.startsWith('/update/')) {
    const id = req.url.split('/')[2]; // Pega o ID da URL
    let body = '';

    req.on('data', chunk => {
      body += chunk;
    });

    req.on('end', async () => {
      try {
        const messages = await readMessages();
        const index = messages.findIndex(msg => msg.id == id);

        if (index === -1) {
          throw new Error('Mensagem não encontrada');
        }

        messages[index].message = body; // Atualiza a mensagem
        await saveMessages(messages); // Salva as mensagens atualizadas
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ message: 'Mensagem atualizada com sucesso', data: messages[index] }));
      } catch (error) {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: error.message }));
      }
    });
  }
  // Endpoint para excluir uma mensagem
  else if (req.method === 'DELETE' && req.url.startsWith('/delete/')) {
    const id = req.url.split('/')[2]; // Pega o ID da URL

    try {
      const messages = await readMessages();
      const newMessages = messages.filter(msg => msg.id != id); // Filtra a mensagem a ser excluída

      if (messages.length === newMessages.length) {
        throw new Error('Mensagem não encontrada');
      }

      await saveMessages(newMessages); // Salva as mensagens atualizadas
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ message: 'Mensagem excluída com sucesso' }));
    } catch (error) {
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: error.message }));
    }
  } else {
    // Endpoint não encontrado
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Endpoint não encontrado' }));
  }
});

// Inicia o servidor
server.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
