package com.svalero.retrobyte.dao;

import com.svalero.retrobyte.domain.User;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface UserDao {
    @SqlQuery("SELECT * FROM users")
    @UseRowMapper(UserMapper.class)
    List<User> getAllUsers();

    @SqlQuery("SELECT * FROM users WHERE id_user = ?")
    @UseRowMapper(UserMapper.class)
    User getOneUser(int id_user);

    @SqlQuery("SELECT * FROM users WHERE username = ? AND password = SHA1(?)")
    @UseRowMapper(UserMapper.class)
    User getUser(String username, String password);
    //Vamos a tener que hacer un acceso teniendo el username que debe se UNIQUE en BD y el password
    //Esto va devolver unicamente una fila unica , ya que el username es UNIQUE
// En Oracle seria asi..
//    @SqlQuery("SELECT * FROM users WHERE name LIKE '%'||:searchTerm||'%'" +
//            "OR username LIKE '%'||:searchTerm||'%' OR city LIKE '%'||:searchTerm||'%' OR role LIKE '%'||:searchTerm||'%'")
//    @UseRowMapper(UserMapper.class)
//    List<User> getUsers(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM users WHERE name LIKE CONCAT('%',:searchTerm,'%') " +
            "OR username LIKE CONCAT('%',:searchTerm,'%') OR city LIKE CONCAT('%',:searchTerm,'%') OR role LIKE CONCAT('%',:searchTerm,'%')")
    @UseRowMapper(UserMapper.class)
    List<User> getUsers(@Bind("searchTerm") String searchTerm);

    //Updates
    // En ORACLE SHA1 se convierte en---> standard_hash , es exctamente lo mismo
    @SqlUpdate("INSERT INTO users (name, username, password,role,tel,address,zip_code,city,country) VALUES (?,?,SHA1(?),?,?,?,?,?,?)")
    //   @GetGeneratedKeys
    //La contraseña la cifro justo antes de grabarla en la BD
    int addUser(String name,String username, String password, String role, String tel,String address,String zip_code,String city,String country);
    @SqlUpdate("DELETE FROM users WHERE id_user = ?")
    int removeUser(int id_user);
    @SqlUpdate("UPDATE users set name =?, username=?, password=SHA1(?), role = ?,tel = ?,address= ?,zip_code= ?,city= ?,country= ? WHERE id_user = ?")
    int updateUser(String name,String username,String password,String role,String tel,String address,String zip_code,String city,String country, int id_user);


}
