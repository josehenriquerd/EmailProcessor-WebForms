using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Web.UI;

public partial class _Default : System.Web.UI.Page
{
    protected void BtnProcessar_Click(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile)
        {
            lblMensagem.Text = "Por favor, envie um arquivo .txt com e-mails.";
            lblMensagem.CssClass = "alert alert-warning w-100";
            lblMensagem.Visible = true;
            return;
        }

        try
        {
            string[] linhas = new StreamReader(FileUpload1.FileContent).ReadToEnd()
                .Split(new[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries);

            List<string> emailsUnicos = linhas
                .Select(email => email.Trim().ToLower())
                .Where(email => !string.IsNullOrWhiteSpace(email))
                .Distinct()
                .ToList();

            string pastaTxt = Server.MapPath("~/App_Data/");
            if (!Directory.Exists(pastaTxt))
                Directory.CreateDirectory(pastaTxt);

            foreach (var file in Directory.GetFiles(pastaTxt, "*.txt"))
                File.Delete(file);

            string pastaZip = Server.MapPath("~/Downloads/");
            if (!Directory.Exists(pastaZip))
                Directory.CreateDirectory(pastaZip);

            string zipPath = Path.Combine(pastaZip, "Emails.zip");
            string csvPath = Path.Combine(pastaZip, "Emails.csv");

            if (File.Exists(zipPath)) File.Delete(zipPath);
            if (File.Exists(csvPath)) File.Delete(csvPath);

            List<object> arquivosSimples = new List<object>();

            for (int i = 0; i < emailsUnicos.Count; i += 5)
            {
                var grupo = emailsUnicos.Skip(i).Take(5).ToList();
                string nomeArquivo = (i / 5 + 1).ToString("D2") + ".txt";
                string caminho = Path.Combine(pastaTxt, nomeArquivo);
                File.WriteAllLines(caminho, grupo);

                arquivosSimples.Add(new
                {
                    Name = nomeArquivo,
                    Path = ResolveUrl("~/App_Data/" + nomeArquivo),
                    Emails = grupo.Select(email => Server.HtmlEncode(email)).ToList()
                });
            }

            // Cria ZIP
            using (FileStream zipToOpen = new FileStream(zipPath, FileMode.Create))
            {
                using (ZipArchive archive = new ZipArchive(zipToOpen, ZipArchiveMode.Update))
                {
                    foreach (var arquivo in arquivosSimples)
                    {
                        string nome = arquivo.GetType().GetProperty("Name").GetValue(arquivo).ToString();
                        string caminho = Path.Combine(pastaTxt, nome);
                        archive.CreateEntryFromFile(caminho, nome);
                    }
                }
            }

            // Cria CSV
            File.WriteAllLines(csvPath, emailsUnicos.Select(email => string.Format("\"{0}\"", email)), Encoding.UTF8);

            // Preenche componentes
            EmailsRepeater.DataSource = arquivosSimples;
            EmailsRepeater.DataBind();

            EmailsGridView.DataSource = emailsUnicos.Select(email => new { Email = email });
            EmailsGridView.DataBind();

            EmailsListRepeater.DataSource = emailsUnicos.Select(email => new { Email = email });
            EmailsListRepeater.DataBind();

            lnkZipDownload.NavigateUrl = ResolveUrl("~/Downloads/Emails.zip");
            lnkZipDownload.Visible = true;

            lnkCsvDownload.NavigateUrl = ResolveUrl("~/Downloads/Emails.csv");
            lnkCsvDownload.Visible = true;

            // Salva histórico do upload
            Session["UltimoUpload"] = DateTime.Now.ToString("dd/MM/yyyy HH:mm");

            lblMensagem.Text = string.Format("{0} e-mails únicos processados com sucesso.", emailsUnicos.Count);
            lblMensagem.CssClass = "alert alert-success w-100";
            lblMensagem.Visible = true;

            lblEstatisticas.Text = string.Format("📊 {0} no total | {1} duplicados removidos | {2} arquivos gerados.",
                linhas.Length,
                linhas.Length - emailsUnicos.Count,
                arquivosSimples.Count);
            lblEstatisticas.Visible = true;
        }
        catch (Exception ex)
        {
            lblMensagem.Text = "Erro ao processar: " + ex.Message;
            lblMensagem.CssClass = "alert alert-danger w-100";
            lblMensagem.Visible = true;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && Session["UltimoUpload"] != null)
        {
            lblUltimoUpload.Text = "🕓 Último upload: " + Session["UltimoUpload"].ToString();
        }
    }

    public string GetHtmlEmailsAsList(object lista)
    {
        var emails = lista as List<string>;
        if (emails == null || emails.Count == 0) return "";

        string html = "";
        foreach (var email in emails)
        {
            html += "<li class='dropdown-item'>" + email + "</li>";
        }
        return html;
    }
}
