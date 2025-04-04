<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Processador de E-mails</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            font-family: 'Segoe UI', sans-serif;
            padding: 2rem;
            transition: 0.3s ease background, color;
        }

        .dark-mode {
            background: #121212 !important;
            color: #e0e0e0 !important;
        }

        .dark-mode .container-box {
            background: #1f1f1f !important;
        }

        .dark-mode .table th {
            background-color: #343a40 !important;
        }

        .dark-mode .table td,
        .dark-mode .list-group-item {
            background-color: #2c2c2c !important;
            color: #e0e0e0 !important;
        }

        .container-box {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            transition: 0.3s ease background, color;
        }

        .section {
            margin-bottom: 2rem;
        }

        .btn-custom {
            background-color: #6c63ff;
            color: #fff;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            transition: 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #574fd6;
            transform: scale(1.03);
        }

        .table {
            margin-top: 3rem;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .table th {
            background-color: #6c63ff;
            color: white;
            font-weight: bold;
            text-align: left;
            padding: 0.75rem;
        }

        .table td {
            background-color: #fff;
            padding: 0.75rem;
            border-top: 1px solid #dee2e6;
        }

        .table-striped tbody tr:nth-of-type(odd) td {
            background-color: #f8f9fa;
        }

        .fade-in-up {
            animation: fadeInUp 0.5s ease both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .toggle-visual-btn {
            margin-top: 1rem;
            margin-bottom: 1rem;
        }

        .list-files {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .dropdown-file {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: 0.3s ease;
            border: 1px solid #dee2e6;
        }

        .dropdown-file:hover {
            background-color: #f1f3f5;
        }

        .file-link {
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            color: #343a40;
            transition: color 0.3s;
        }

        .file-link:hover {
            color: #6c63ff;
        }

        .btn-toggle {
            background-color: white;
            border: 1px solid #ced4da;
            color: #495057;
            padding: 0.4rem 0.75rem;
            border-radius: 5px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.3s ease;
        }

        .btn-toggle:hover {
            background-color: #e9ecef;
            border-color: #adb5bd;
        }

        .icon-arrow {
            transition: transform 0.3s ease;
            display: inline-block;
        }

        .dropdown-file.show .icon-arrow {
            transform: rotate(90deg);
        }

        .dropdown-content {
            margin-top: 0.75rem;
            padding: 0;
            max-height: 0;
            overflow: hidden;
            opacity: 0;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
            background: #ffffff;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0,0,0,0.05);
        }

        .dropdown-file.show .dropdown-content {
            padding: 0.5rem 1rem;
            max-height: 500px;
            opacity: 1;
        }

        .dropdown-content ul {
            padding-left: 1rem;
            margin-bottom: 0;
        }

        .dropdown-content li {
            font-size: 0.9rem;
            color: #333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container-box">
            <!-- Envio -->
            <div class="section">
                <h4>1. Envio do Arquivo</h4>
                <div class="input-group mb-3">
                    <label class="input-group-text" for="FileUpload1">📎 Selecionar</label>
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                    <asp:Button ID="BtnProcessar" runat="server" Text="Processar" CssClass="btn btn-custom ms-2" OnClick="BtnProcessar_Click" />
                </div>
            </div>

            <!-- Métricas -->
            <div class="section bg-light p-3 rounded">
                <h4>2. Métricas da Análise</h4>
                <asp:Label ID="lblMensagem" runat="server" CssClass="alert w-100 fade-in" Visible="false" />
                <asp:Label ID="lblEstatisticas" runat="server" CssClass="alert alert-secondary w-100 fade-in" Visible="false" />
                <asp:HyperLink ID="lnkZipDownload" runat="server" CssClass="btn btn-outline-primary mt-3 me-2" Target="_blank" Visible="true">
                    📦 Baixar tudo em ZIP
                </asp:HyperLink>
                <asp:HyperLink ID="lnkCsvDownload" runat="server" CssClass="btn btn-outline-success mt-3" Target="_blank" Visible="true">
                    📄 Baixar CSV
                </asp:HyperLink>
                <asp:Label ID="lblUltimoUpload" runat="server" CssClass="d-block mt-3 text-muted" />
            </div>

            <!-- Resultados -->
            <div class="section">
                <h4>3. Resultados</h4>

                <!-- Funcionalidades Extras -->
                <div class="mb-3 d-flex flex-wrap gap-2">
                    <button type="button" class="btn btn-outline-secondary" onclick="toggleView()">👁 Alterar Visualização</button>
                    <button type="button" class="btn btn-outline-success" onclick="copiarEmails()">📋 Copiar E-mails</button>
                    <button type="button" class="btn btn-dark" onclick="toggleDarkMode()">🌙 Alternar Tema</button>
                </div>
                <!-- Arquivos gerados (cards bonitos com ícones) -->
                <div class="list-files mt-4">
                    <asp:Repeater ID="EmailsRepeater" runat="server">
                        <ItemTemplate>
                            <div class="dropdown-file">
                                <div class="d-flex justify-content-between align-items-center w-100">
                                    <div>
                                        <a href='<%# Eval("Path") %>' download class="file-link">📎 <%# Eval("Name") %></a>
                                    </div>
                                    <button type="button" class="btn btn-toggle" onclick="toggleDropdown(this)">
                                        Resumo <span class="icon-arrow">▶</span>
                                    </button>
                                </div>
                                <div class="dropdown-content">
                                    <ul class="mb-0">
                                        <%# GetHtmlEmailsAsList(Eval("Emails")) %>
                                    </ul>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <!-- Tabela de e-mails -->
                <asp:GridView ID="EmailsGridView" runat="server" CssClass="table table-bordered table-striped table-sm fade-in-up" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Email" HeaderText="E-mails Únicos" />
                    </Columns>
                </asp:GridView>

                <!-- Lista de e-mails alternativa -->
                <div id="listView" style="display:none;" class="fade-in-up">
                    <ul class="list-group">
                        <asp:Repeater ID="EmailsListRepeater" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item">📧 <%# Eval("Email") %></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </form>

    <script>
        function toggleDropdown(button) {
            const wrapper = button.closest('.dropdown-file');
            wrapper.classList.toggle('show');
        }

        function toggleView() {
            const grid = document.getElementById('<%= EmailsGridView.ClientID %>');
            const list = document.getElementById('listView');
            grid.style.display = grid.style.display === "none" ? "" : "none";
            list.style.display = list.style.display === "none" ? "" : "none";
        }

        function copiarEmails() {
            const itens = [...document.querySelectorAll("#listView li")];
            const texto = itens.map(el => el.textContent.replace("📧 ", "")).join("\n");
            navigator.clipboard.writeText(texto).then(() => alert("E-mails copiados com sucesso!"));
        }

        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
        }
    </script>
</body>
</html>
