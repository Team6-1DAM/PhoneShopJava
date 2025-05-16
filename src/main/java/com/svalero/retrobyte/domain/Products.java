package com.svalero.retrobyte.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;

@NoArgsConstructor
@Data
@AllArgsConstructor
@Getter
public class Products {
    private int id_product;
    private String product_name;
    private String description;
    private float sale_price;
    private boolean stock_units;
    private String image;
    private Date release_date;
    private String product_status;
    private int id_supplier;
}


