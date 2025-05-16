package com.svalero.retrobyte.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Getter
public class User {
    private int id_user;
    private String name;
    private String username;
    private String password;
    private String role;
    private String tel;
    private String address;
    private String zip_code;
    private String city;
    private String country;
    private boolean active;
    private Date entry_date;
    private float credit_limit;
}
