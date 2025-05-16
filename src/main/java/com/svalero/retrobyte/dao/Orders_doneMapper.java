package com.svalero.retrobyte.dao;

import com.svalero.retrobyte.domain.Orders_done;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Orders_doneMapper implements RowMapper<Orders_done> {
    @Override
    public Orders_done map(ResultSet rs, StatementContext ctx) throws SQLException {
    //    User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(rs.getInt("id_user")));
    //    Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(rs.getInt("id_product")));

    //Nota:
    //He probado a realizar la relacion integrando el objeto user y products en la tabla pero.....
    //Va muy bien hasta que se borra un producto de la BD, muy habitual en mi BD de mi tienda online, puesto son productos de 2ª mano
    //y suelen ser unicos, cada producto tiene un estado y precio que puede ser distinto dependiendo de ese estado y como se compro.
    //Si borro un producto relacionado con un pedido de la BD da problemas porque no lo encuentra y lo rellena con nulo, asi que para
    //evitar esto y poder guardar informacion de cual fue el producto del pedido que se realizo, lo guardo en campos sin realizar relacion
    //en siguientes versiones se podria crear una tabla de products_history y realizar la relacion sobre esa tabla

    //Con el Ususario lo puedo hacer, ya que si no exite no podra acceder, pero para listados y manejo de datos de pedidos es mejor tb
    //quitar la referencia a un posible usuario que nos hayamos cargado, esto en el mundo real es poco probable, cargarte usuarios,
    //pero en el proyecto que estamos haciendo, esta dentro de un DAO y hay que Eliminar Usuarios como requisito del proyecto.

        return new Orders_done(rs.getInt("id_order"),
                rs.getDate("order_date"),
                rs.getFloat("total_price"),
                rs.getInt("id_product"),
                rs.getString("product_name"),
                rs.getString("supplier_name"),
                rs.getInt("id_user"),
                rs.getString("username"),
                rs.getBoolean("restored"));

    }
}
