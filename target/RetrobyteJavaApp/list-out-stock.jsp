<%@ page import="com.svalero.retrobyte.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrobyte.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrobyte.dao.ProductsDao" %>
<%@ page import="com.svalero.retrobyte.dao.UserDao" %>
<%@ page import="com.svalero.retrobyte.domain.Suppliers" %>
<%@ page import="com.svalero.retrobyte.dao.SuppliersDao" %>
<%@ page import="com.svalero.retrobyte.domain.Products" %>
<%@ page import="com.svalero.retrobyte.util.CurrencyUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>


<main>
    <br/>
    <div class="container bg-dark">
        <h2 class="text-danger">Listado de Productos sin stock y Proveedor que lo suministra</h2>

        <br/>

    </div>

    <div class="container my-6 bg-dark">
        <%
            if (!role.equals("admin")){
                response.sendRedirect("/retrobyte");
            }
            //Si no eres el administrador no puedes entrar a esta pagina
        %>
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th><a href="remove-all-selects-products" type="button" class="btn btn-sm btn-outline-danger">Eliminar Todos los Productos sin Stock</a></th>

                    </tr>
                    <tr>
                        <th>Id producto</th>
                        <th>Nombre Producto</th>
                        <th>Precio</th>
                        <th>Nombre Proveedor</th>
                        <th>Telefono</th>
                        <th>Email</th>
                        <th>Website</th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        List<Products> listproducts = null;
                        listproducts = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getAllProducts());
                        for (Products products : listproducts) {
                            if (!products.isStock_units()) {
                    %>
                                <tr>
                                    <td><%=products.getId_product()%></td>
                                    <td><%=products.getProduct_name()%></td>
                                    <td><%= CurrencyUtils.format(products.getSale_price()) %></td>
                                    <%
                                        try {
                                            Database.connect();
                                        } catch (ClassNotFoundException e) {
                                            throw new RuntimeException(e);
                                        } catch (SQLException e) {
                                            throw new RuntimeException(e);
                                        }
                                        int id_supplier = products.getId_supplier();
                                        Suppliers suppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(id_supplier));
                                    %>
                                    <td><%=suppliers.getName()%></td>
                                    <td><%=suppliers.getTel()%></td>
                                    <td><%=suppliers.getEmail()%></td>
                                    <td><%=suppliers.getWebsite()%></td>
                                    <td><a href="remove-products?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a></td>
                                </tr>
                    <%
                                }
                        }
                    %>
                    </tbody>
                </table>

        <br/>
        <p><a href="index-suppliers.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Proveedores</a></p>
    </div>

</main>

<%@include file="includes/footer.jsp"%>
