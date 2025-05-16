package com.svalero.retrobyte.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class Orders_done {
    private int id_order;
    private Date order_date;
    private float total_price;
    private int id_product;
    private String product_name;
    private String supplier_name;
    private int id_user;
    private String username;
    private boolean restored;
}
