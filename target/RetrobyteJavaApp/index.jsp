<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.retrobyte.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrobyte.domain.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrobyte.dao.ProductsDao" %>
<%@ page import="com.svalero.retrobyte.util.CurrencyUtils" %>
<%@ page import="com.svalero.retrobyte.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>



<main>
    <%--    <div class="bg-image2">--%>
    <div class="py-1 container">
        <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
            <%
                if (role.equals("anonymous")) {
            %>
            <a href="login.jsp" title="Iniciar sesión"><img src="icons/user1.png" height="50" width="50"/></a>
            <%
            } else {
            %>
            <h4 class="text-light"><%= username_init%></h4>
            <p><a href="register-user.jsp?id_user=<%=user_id%>" class="link-light link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">&nbsp;&nbsp;Modificar mi Usuario&nbsp;&nbsp;</a></p>
            <a href="logout" title="Cerrar sesión"><img src="icons/exit.png" height="50" width="50"/></a>
            <%
                }
            %>
        </div>
    </div>


    <section class="py-1 text-center container">
        <div class="row py-lg-1">
            <div class="col-lg-6 col-md-8 mx-auto">
                <%--                <h1 class="text-success"><strong>RetroByte</strong></h1>--%>

                <%
                    if (role.equals("admin")){
                %>
                <h5 class="text-light">---Modo Administrador---</h5>
                <br/>
                <a href="register-product.jsp" class="btn btn-sm btn-outline-primary" type="button">Alta Producto</a>
                <a href="index-user.jsp" class="btn btn-sm btn-outline-danger" type="button">Usuarios</a>
                <%--                <a href="index-suppliers.jsp" class="btn btn-sm btn-outline-primary" type="button">Proveedores</a>--%>
                <%--                <a href="all-orders_done.jsp" class="btn btn-sm btn-outline-danger" type="button">Pedidos Realizados</a>--%>
                <%
                } else {
                %>
                <h5 class="text-light">---Productos Estrella---</h5>
                <%--                <%--%>
                <%--                    if (role.equals("user")){--%>
                <%--                %>--%>
                <%--                <a href="index-sales.jsp" class="btn btn-sm btn-outline-primary" type="button">Ver mis pedidos</a>--%>
                <%--                <%--%>
                <%--                    }--%>
                <%--                %>--%>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <%--    <div class="between-sections"></div>--%>

    <%--    <section class="slider-frame">--%>
    <%--        <ul>--%>
    <%--            <li><img src="./icons/equipo.jpg" alt=""></li>--%>
    <%--            <li><img src="./icons/placa.jpg" alt=""></li>--%>
    <%--            <li><img src="./icons/lisa.jpg" alt=""></li>--%>
    <%--            <li><img src="./icons/servicio.jpg" alt=""></li>--%>
    <%--        </ul>--%>
    <%--    </section>--%>

    <%--    <div class="between-sections"></div>--%>
    <%--    <div class="between-sections"></div>--%>


    <div class="title-words">
        <div class="shadows">
            <span>n</span>
            <span>u</span>
            <span>e</span>
            <span>s</span>
            <span>t</span>
            <span>r</span>
            <span>o</span>
            <span>&NonBreakingSpace;</span>
            <span>c</span>
            <span>a</span>
            <span>t</span>
            <span>a</span>
            <span>t</span>
            <span>a</span>
            <span>l</span>
            <span>o</span>
            <span>g</span>
            <span>o</span>
        </div>
    </div>
    <%--    <div class="between-sections"></div>--%>
    <%--    <div class="between-sections"></div>--%>
    <%--    </div>--%>

    <div class="album py-5 bg-body-tertiary bg-image">
        <div class="container">
            <form class="row g-2" id="search-form" method="GET">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Buscar en Productos" name="search" id="search-input">
                    <button type="submit" class="btn btn-outline-danger"  id="search-button">Buscar</button>
                </div>
            </form>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <%
                    String search = "";
                    if (request.getParameter("search") != null)
                        search = request.getParameter("search");

                    try {
                        Database.connect();
                    } catch (ClassNotFoundException e) {
                        throw new RuntimeException(e);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    List<Products> listaproductos = null;
                    if (search.isEmpty()) {
                        listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getAllProducts());
                    } else {
                        final String searchTerm = search;
                        listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getProducts(searchTerm));
                    }
                    for (Products products : listaproductos) {
                %>
                <div class="col">
                    <div class="card shadow-sm">

                        <img src="../retrobyte_pictures/<%=products.getImage()%>" style="max-width: 480px;max-height: 360px;"/>
                        <div class="card-body">
                            <p class="card-text"><strong><%= products.getProduct_name() %></strong>&nbsp;&nbsp;&nbsp;Lanzamiento:&nbsp;<strong><%=DateUtils.formatUser(products.getRelease_date())%></strong></p>
                            <p class="card-text"><%= products.getDescription() %> </p>

                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="view-product.jsp?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                                    <%
                                        if (role.equals("admin")){
                                    %>
                                    <a href="register-product.jsp?id_product=<%=products.getId_product()%>"  type="button" class="btn btn-sm btn-outline-primary">Editar</a>
                                    <a href="remove-products?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                                    <%
                                        }
                                    %>
                                </div>
                                <small class="text-body-secondary">Precio: <%= CurrencyUtils.format(products.getSale_price()) %> </small>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

        </div>
    </div>




</main>

<%@include file="includes/footer.jsp"%>


