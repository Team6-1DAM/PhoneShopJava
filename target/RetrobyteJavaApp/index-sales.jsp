<%@ page import="com.svalero.retrobyte.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrobyte.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrobyte.dao.ProductsDao" %>
<%@ page import="com.svalero.retrobyte.dao.UserDao" %>
<%@ page import="com.svalero.retrobyte.domain.Products" %>
<%@ page import="com.svalero.retrobyte.domain.Orders_done" %>
<%@ page import="com.svalero.retrobyte.dao.Orders_doneDao" %>
<%@ page import="com.svalero.retrobyte.util.CurrencyUtils" %>
<%@ page import="com.svalero.retrobyte.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>


        <main>
            <%
                if (request.getSession().getAttribute("id_user") == null) {
                    response.sendRedirect("index.jsp");
                }
                        //Si no eres un usuario registrado no puedes entrar a esta pagina
            %>
            <br/>
            <div class="container bg-dark">
                <h2 class="text-danger">Listado de Productos pedidos por <%=username_init%></h2>

                <br/>

            </div>

            <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Id del Pedido</th>
                        <th>Fecha del Pedido</th>
                        <th>Id del Producto</th>
                        <th>Nombre Producto</th>
                        <th></th>
                        <th>Nombre del Proveedor</th>
                        <th>Precio Total</th>
                        <th>Producto Restaurado</th>
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
                        final int finaluser_id = user_id;
                        List<Orders_done> orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getOrders_doneByUser(finaluser_id));

                    %>
                    <%
                        for (Orders_done orders_done : orders_dones) {

                    %>
                    <tr>
                        <td><%=orders_done.getId_order()%></td>
                        <td><%=DateUtils.formatOrder(orders_done.getOrder_date())%></td>
                        <td><%=orders_done.getId_product()%></td>
                        <td><%=orders_done.getProduct_name()%></td>
                        <td><a href="view-product-history.jsp?id_product=<%= orders_done.getId_product()%>" type="button" class="btn btn-sm btn-outline-danger">Ver</a></td>
                        <td><%=orders_done.getSupplier_name()%></td>
                        <td><%= CurrencyUtils.format(orders_done.getTotal_price()) %></td>
                        <%
                            String mensaje_restored;
                            if (orders_done.isRestored()) {
                                mensaje_restored = "Si";
                            } else {
                                mensaje_restored = "No";
                            }
                        %>
                        <td><%=mensaje_restored%></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <br/>
                <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver al Menu Inicial</a></p>
            </div>

        </main>

        <%@include file="includes/footer.jsp"%>

