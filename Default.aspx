<%@ Page Language="C#" %>
<script runat="server">
    // Página de entrada: redirige al listado (pages/Index.aspx).
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/pages/Index.aspx");
    }
</script>
