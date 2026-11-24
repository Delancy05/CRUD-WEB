using System;
using System.Web.UI;

namespace CRUD
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Open Graph necesita URLs absolutas: se arman con el dominio actual.
            string dominio = Request.Url.GetLeftPart(UriPartial.Authority);
            metaOgUrl.Content = Request.Url.GetLeftPart(UriPartial.Path);
            metaOgImage.Content = dominio + ResolveUrl("~/img/og-cover.png");

            // Resalta en el menú la página actual.
            string actual = Request.AppRelativeCurrentExecutionFilePath ?? string.Empty;
            string op = Request.QueryString["op"];

            bool enCrud = actual.EndsWith("/Crud.aspx", StringComparison.OrdinalIgnoreCase);
            bool crear = enCrud && string.Equals(op, "C", StringComparison.OrdinalIgnoreCase);

            lnkListado.Attributes["class"] = "nav-link" +
                (actual.EndsWith("/Index.aspx", StringComparison.OrdinalIgnoreCase) ? " active" : string.Empty);
            lnkNuevo.Attributes["class"] = "nav-link" + (crear ? " active" : string.Empty);
        }
    }
}
