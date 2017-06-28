package com.demo.dao.impl;

import java.io.FileOutputStream;
import java.sql.DriverManager;
import java.sql.SQLException;


import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.component.Components;
import net.sf.dynamicreports.report.builder.datatype.DataTypes;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrderReportsDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.CustomerContactDetails;
import com.demo.model.OrderDetails;
import com.demo.model.OrderHeader;
import com.mysql.jdbc.Connection;

@Repository("orderReportDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderReportsDao implements OrderReportsDaoInt {

	@Autowired
	private OrdersDaoInt ordersDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	@Autowired
	private CustomerContactDetailsDaoInt contactDetails;

	private OrderHeader orderHeader;
	private CustomerContactDetails customerContact;

	
	public Connection getConnection(){
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/velaphandadb","Velaphanda", "@Vela2017");
		} catch (SQLException e) {
			e.printStackTrace();
			return connection;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return connection;
		}
		return connection;
	}
	@Override
	public void createPdf(Integer recordID) {
       System.out.println("Out to print");
		try {
			Connection connection = getConnection();
			JasperReportBuilder report = DynamicReports.report();// a new report

				report.columns(
						Columns.column("Part Number:", "Part_Number",
								DataTypes.stringType()).setHorizontalAlignment(
								HorizontalAlignment.LEFT),
						Columns.column("Description", "Description",
								DataTypes.stringType()),
						Columns.column("Qty Ordered", "Quantity",
								DataTypes.integerType()),
						Columns.column("Qty Delivered", "Quantity",
								DataTypes.integerType())
								.setHorizontalAlignment(
										HorizontalAlignment.LEFT))
						.title(// title of the report
						Components.text("Delivery Note Report")
								.setHorizontalAlignment(
										HorizontalAlignment.CENTER))
						.pageFooter(Components.pageXofY()).setDataSource("SELECT Part_Number, Description, Quantity, FROM order_details where Order_Number =" +recordID, connection);
				
			report.show();// show the report
			report.toPdf(new FileOutputStream(
					"/C:/Users/Mohapi/Desktop/BackUp/report.pdf"));
		} catch (Exception e) {

		}
	}
}
