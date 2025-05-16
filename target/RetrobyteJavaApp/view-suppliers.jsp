<%@ page import="com.svalero.retrobyte.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrobyte.domain.User" %>
<%@ page import="com.svalero.retrobyte.dao.UserDao" %>
<%@ page import="com.svalero.retrobyte.domain.Suppliers" %>
<%@ page import="com.svalero.retrobyte.dao.SuppliersDao" %>
<%@ page import="com.svalero.retrobyte.util.DateUtils" %>
<%@ page import="com.svalero.retrobyte.util.CurrencyUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<main>
    <%
        if (!role.equals("admin")){
            response.sendRedirect("/retrobyte");
        }
        //Si no eres el administrador no puedes entrar a esta pagina
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        int id_supplier = Integer.parseInt(request.getParameter("id_supplier"));
        Suppliers suppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(id_supplier));
    %>

    <div class="container my-3">

        <div class="row">
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-dark">
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado"><h2 class="text-danger">Ver Proveedor</h2></td>
                        <td class="centrado"></td>
                    </tr>
                    <tr>
                        <td class="centrado">Nombre</td>
                        <td class="centrado"><%=suppliers.getName()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Telefono</td>
                        <td class="centrado"><%=suppliers.getTel()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Direccion</td>
                        <td class="centrado"><%=suppliers.getAddress()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Codigo Postal</th>
                        <td class="centrado"><%=suppliers.getZip_code()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Ciudad</th>
                        <td class="centrado"><%=suppliers.getCity()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Pais</th>
                        <td class="centrado"><%=suppliers.getCountry()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Website</th>
                        <td class="centrado"><%=suppliers.getWebsite()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Email</th>
                        <td class="centrado"><%=suppliers.getEmail()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Fecha ALta</th>
                        <td class="centrado"><%=DateUtils.formatUser(suppliers.getEntry_date())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Credito del Proveedor</th>
                        <td class="centrado"><%=CurrencyUtils.format(suppliers.getCredit_limit())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Proveedor Activo</th>
                        <%
                            String mensaje_supplier_active;
                            if (!suppliers.getActive()) {
                                mensaje_supplier_active = "No";
                            } else {
                                mensaje_supplier_active = "Si";
                            }
                        %>
                        <td class="centrado"><%=mensaje_supplier_active%></td>
                    </tr>
                </table>

            </div>
        </div>
        <br/>
        <p><a href="index-suppliers.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Proveedores</a></p>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

