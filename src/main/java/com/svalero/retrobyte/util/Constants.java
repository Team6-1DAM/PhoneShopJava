package com.svalero.retrobyte.util;

public class Constants {
    public static final String DATABASE = "tiendaonlineretrov6";
    public static final String USERNAME ="mrubio8";
    public static final String PASSWORD ="mrubio8";


//    public static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//    public static final String CONNECTION_STRING = "jdbc:oracle:thin:@//localhost:1521/xe";

    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String CONNECTION_STRING = "jdbc:mysql://localhost:3306/" + DATABASE;

    public static final String DATE_PATTERN = "yyyy-MM-dd";
    public static final String USER_DATE_PATTERN = "dd.MM.yyyy";
    public static final String ORDER_DATE_PATTERN ="dd-MM-yyyy";
}
