package com.demo.dao.impl;

import java.io.Serializable;
import java.sql.*;

import org.hibernate.HibernateException;
import org.hibernate.id.IdentifierGenerator;

import com.mysql.jdbc.ResultSet;

public class OrderNumGenerator implements IdentifierGenerator{

	@Override
	public Serializable generate(org.hibernate.engine.SessionImplementor session,
			Object arg1) throws HibernateException {
			String prefix = "OD-VEL-";
			Connection connection = null;
		    try {

		    	 connection = session.connection();
		        PreparedStatement ps = connection
		                .prepareStatement("SELECT MAX(vlaue) as vlaue from SpareOrders");

		        ResultSet rs = (ResultSet) ps.executeQuery();
		        if (rs.next()) {
		            int id = rs.getInt("vlaue");
		            String code = prefix + new Integer(id).toString();
		            System.out.println("Generated Stock Code: " + code);
		            return code;
		        }

		    } catch (SQLException e) {       
		        e.printStackTrace();
		    }
			return null;}
}
