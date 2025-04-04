Aplicação ASP.NET WebForms que processa um arquivo `.txt` com e-mails, remove duplicados, divide em arquivos de 5 e-mails únicos,
gera links de download individuais e exportações completas em `.zip` e `.csv`, exibindo os resultados em uma interface responsiva.

# 📬 Processador de E-mails - Teste Técnico ASP.NET WebForms

Este é um projeto desenvolvido para o teste técnico, com foco em ASP.NET WebForms.  
A aplicação permite o upload de um arquivo `.txt` com e-mails, remove duplicados, divide em arquivos de 5 e-mails e oferece opções de download, visualização e estatísticas.

---

## ✅ Tecnologias utilizadas

- HTML5
- CSS3
- JavaScript (puro)
- jQuery (mínimo)
- ASP.NET WebForms (C#)
- Bootstrap 5.3
- .NET Framework 4.5

---

## 📋 Requisitos do teste (atendidos)

- [x] Receber upload de um arquivo `.txt` contendo 30 ou mais e-mails
- [x] Remover e-mails duplicados
- [x] Gerar múltiplos arquivos `.txt` com 5 e-mails únicos cada (ex: `01.txt`, `02.txt`, ...)
- [x] Exibir links de download dos arquivos gerados
- [x] Mostrar todos os e-mails únicos em uma lista (`GridView` ou `Repeater`)
- [x] Interface **responsiva** utilizando Bootstrap
- [x] Utilizar tecnologias HTML, CSS, JS/jQuery e ASP.NET C#

---

## 🚀 Funcionalidades principais

| Funcionalidade | Descrição |
|----------------|-----------|
| 📤 Upload      | Upload do arquivo `.txt` com os e-mails |
| 🧹 Limpeza     | Remove e-mails duplicados e vazios |
| 📁 Divisão     | Cria arquivos com 5 e-mails cada, nomeados sequencialmente |
| 📥 Download    | Links para baixar cada arquivo gerado |
| 📊 Estatísticas| Exibe contagem total, duplicados removidos, arquivos gerados |
| 📄 GridView    | Lista todos os e-mails únicos em tabela |
| 📝 Repeater    | Cards com nomes de arquivos + dropdown com e-mails |

---

## ✨ Funcionalidades extras implementadas

| Funcionalidade Extra | Descrição |
|----------------------|-----------|
| 📎 Botão para copiar todos os e-mails | Copia para a área de transferência |
| 🌙 Tema Escuro (Dark Mode) | Botão para alternar entre tema claro e escuro |
| 📄 Exportar CSV | Gera um arquivo `.csv` com todos os e-mails únicos |
| 📦 Download em ZIP | Compacta os arquivos `.txt` gerados e oferece para download |
| 🕓 Histórico do último upload | Mostra a data/hora do último processamento |
| 👁 Alternar visualização | Troca entre visualização em tabela e lista |
| 🎨 UI com animações | Layout suave com feedback visual agradável |

---

## ▶️ Como usar

1. Abra o projeto no Visual Studio (preferencialmente 2019+)
2. Compile e execute a aplicação (`F5`)
3. Na interface:
   - Clique em **📎 Selecionar** para escolher seu arquivo `.txt`
   - Clique em **Processar**
4. Após o processamento:
   - Veja as estatísticas e os arquivos gerados
   - Use os botões para copiar, baixar ZIP ou CSV
   - Explore o visual alternativo ou ative o modo escuro

---

## 🖼️ Demonstração (opcional)

![image](https://github.com/user-attachments/assets/cefc1103-b3be-4a5e-bcff-9911c4194063)

![image](https://github.com/user-attachments/assets/ffd93688-4624-4651-804f-36ad53773b28)

![image](https://github.com/user-attachments/assets/d0ba4d09-d6c7-4330-a99a-fa1ac6b0e2b8)

![image](https://github.com/user-attachments/assets/9046842f-1821-4b44-b87c-6fcdeb790e23)




---

## 📁 Estrutura do projeto

```
/WebSite/
│
├── Default.aspx           # Frontend com layout e interações
├── Default.aspx.cs        # Lógica backend (upload, processamento, geração)
├── /Content/              # Bootstrap e CSS customizado
├── /Scripts/              # jQuery
├── /App_Data/             # Armazenamento dos arquivos .txt temporários
├── /Downloads/            # Arquivo ZIP e CSV exportados
└── listaemails.txt        # Arquivo de exemplo com e-mails (opcional)
```

---

## 👨‍💻 Desenvolvido por

José Henrique 
