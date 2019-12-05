/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anntuil;
import java.sql.*;
import javax.servlet.ServletContext;

/**
 *
 * @author Armando Guadalupe Moreno Martinez
 */
public class OracleConnect {
    
    OracleConnect(){}
    
    public static Connection getConnection(ServletContext context){
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                    context.getInitParameter("url"),
                    context.getInitParameter("user"),
                    context.getInitParameter("password")
            );
        }catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }
    
}
