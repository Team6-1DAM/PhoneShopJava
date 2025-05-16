package com.svalero.retrobyte.servlet;

import com.svalero.retrobyte.dao.*;
import com.svalero.retrobyte.domain.Products;
import com.svalero.retrobyte.domain.Suppliers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;


@WebServlet("/place-an-order")
public class PlaceAnOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        HttpSession session = request.getSession();
        int id_user = Integer.parseInt(session.getAttribute("id_user").toString());
        String username = session.getAttribute("username").toString();


// Nota inserta bien la fecha en la bd, que tiene un formato datetime, pero luego al recuperar la informacion
// No lo hace bien, es curioso que con new Date(System.currentTimeMillis() en oracle lo hace bien y se visualiza tb bien


        try {
            Database.connect();

            Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id_product));

            Suppliers suplliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(products.getId_supplier()));
            final int stock_unitsfinal = 0;
            //validacion para restored
            int Restored = 0;
            if (products.getProduct_status().equals("Restaurado")) {
                Restored = 1;
            }
            final int productRestored = Restored;
            Database.jdbi.withExtension(Products_historyDao.class, dao -> dao.addProducts_history(products.getId_product(), products.getProduct_name(),
                    products.getDescription(),products.getSale_price(),products.getImage(),products.getRelease_date(), products.getProduct_status(), products.getId_supplier(),productRestored));

            Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.addOrders_done(new Date(System.currentTimeMillis()),
//            Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.addOrders_done(fechaHoraActual,
                    products.getSale_price(),id_product,products.getProduct_name(),suplliers.getName(),id_user,username,productRestored));

            int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                    dao -> dao.updateProductsStock(stock_unitsfinal,id_product));

            response.sendRedirect("index-sales.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

}

