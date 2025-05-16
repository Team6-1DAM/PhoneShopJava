package com.svalero.retrobyte.dao;

import com.svalero.retrobyte.domain.Suppliers;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;

public class SuppliersMapper implements RowMapper<Suppliers> {
@Override
public Suppliers map(ResultSet rs, StatementContext ctx) throws SQLException {
    return new Suppliers(rs.getInt("id_supplier"),
            rs.getString("name"),
            rs.getString("tel"),
            rs.getString("address"),
            rs.getString("zip_code"),
            rs.getString("city"),
            rs.getString("country"),
            rs.getString("website"),
            rs.getString("email"),
            rs.getBoolean("active"),
            rs.getDate("entry_date"),
            rs.getFloat("credit_limit"));


    }

}
