package com.demo.dao.impl;



import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.component.Components;
import net.sf.dynamicreports.report.builder.datatype.DataTypes;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.exception.DRException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.xml.sax.SAXException;






















import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrderReportsDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.CustomerContactDetails;
import com.demo.model.OrderDetails;
import com.demo.model.OrderHeader;
import com.demo.model.VelaphandaProfile;
import com.demo.service.VelaphandaInt;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ICC_Profile;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.zugferd.exceptions.DataIncompleteException;
import com.itextpdf.text.zugferd.exceptions.InvalidCodeException;
import com.itextpdf.xmp.XMPException;
import com.mysql.jdbc.Connection;

@Repository("orderReportDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderReportsDao implements OrderReportsDaoInt {

	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	
	
	@Override
	public void printReports(Long recordID){
	  String reportName = "ORD000"+recordID;
      
		List<OrderDetails> listItems = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
		JasperReportBuilder report = DynamicReports.report();
		 StyleBuilder stl =DynamicReports.stl.style();
		
		StyleBuilder columnTitleStyle = stl.setBackgroundColor(Color.LIGHT_GRAY);
		
		
		report
		.columns(Columns.column("Part Number", "partNumber",DataTypes.stringType()),
		                Columns.column("Description", "itemDescription",DataTypes.stringType()),
		                Columns.column("Quantity", "quantity",DataTypes.integerType())).setColumnTitleStyle(columnTitleStyle).highlightDetailEvenRows()
		                .title(Components.horizontalList().add(Components.image(getClass().getResourceAsStream("/resources/mainlogo.jpg")).setFixedDimension(80, 80).setHorizontalAlignment(HorizontalAlignment.RIGHT))).setDataSource(listItems);
		
		
		try{
			//report.show();
			report.show(false);
			/*report.toPdf(new FileOutputStream("C:\\VelaphandaReports\\"+reportName+".pdf"
					+ ""));*/
		}catch(DRException e){
			e.printStackTrace();
		}/*catch(FileNotFoundException e){
			e.printStackTrace();
		}*/
		
		
	}

	

}

