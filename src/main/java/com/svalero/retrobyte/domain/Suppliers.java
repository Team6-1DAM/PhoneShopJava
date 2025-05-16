package com.svalero.retrobyte.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter

public class Suppliers {
    private int id_supplier;
    private String name;
    private String tel;
    private String address;
    private String zip_code;
    private String city;
    private String country;
    private String website;
    private String email;
    private Boolean active;
    private Date entry_date;
    private float credit_limit;

}
