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

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.Components;
import net.sf.dynamicreports.report.builder.datatype.DataTypes;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilders;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.constant.VerticalAlignment;
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

@Repository("orderReportDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderReportsDao implements OrderReportsDaoInt {

	@Autowired
	private OrdersDaoInt ordersDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	@Autowired
	private CustomerContactDetailsDaoInt contactDetails;
	@Autowired
	private VelaphandaInt velaphandaInt;
	
	private OrderHeader orderHeader;
	private CustomerContactDetails customerContact;
	private VelaphandaProfile profile;

	@Override
	public void printReports(Long recordID){
		
		
		
		String reportName = "ORD000"+recordID;
	      
		List<OrderDetails> listItems = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
		orderHeader = ordersDaoInt.getOrder(recordID);
		profile = velaphandaInt.getVelaphandaAddress("Velaphanda Trading & Projects");
		customerContact = contactDetails.getContactPerson(orderHeader.getCustomer().getCustomerName());
		
		
		JasperReportBuilder report = DynamicReports.report();
		 StyleBuilder stl =DynamicReports.stl.style();
		 
		 StyleBuilder columnTitleStyle = stl.setBackgroundColor(Color.LIGHT_GRAY);
		 StyleBuilder boldStyle  = DynamicReports.stl.style().bold();
		 StyleBuilder boldCenteredStyle = DynamicReports.stl.style(boldStyle).setHorizontalAlignment(HorizontalAlignment.CENTER);
		StyleBuilder titleStyle = DynamicReports.stl.style(boldCenteredStyle)
                .setVerticalAlignment(VerticalAlignment.MIDDLE)
                .setFontSize(15);
		 StyleBuilder italicStyle1  = DynamicReports.stl.style().italic();
		 StyleBuilder boldCenteredStyle1 = DynamicReports.stl.style(italicStyle1).setHorizontalAlignment(HorizontalAlignment.CENTER);
		StyleBuilder titleStyle1 = DynamicReports.stl.style(boldCenteredStyle1)
                .setHorizontalAlignment(HorizontalAlignment.LEFT)
                .setFontSize(8);


		//report.title(Components.horizontalList().add(Components.image(getClass().getResourceAsStream("/resources/mainlogoo.jpg")).setFixedDimension(60, 60).setHorizontalAlignment(HorizontalAlignment.CENTER)));	
		//report.title(Components.text("\n\n"));
		report.title(//shows report title
                
                Components.horizontalList()
  .add(
		  Components.image(getClass().getResourceAsStream("/resources/mainlogoo.jpg")).setFixedDimension(80, 80).setHorizontalAlignment(HorizontalAlignment.CENTER))
      
  .newRow()
  ,  
              
  Components.horizontalList()
  .add(
      
		  Components.text("\n\nDELIVERY TO ").setStyle(titleStyle).setHorizontalAlignment(HorizontalAlignment.LEFT),
		  Components.text("\n\nDELIVERY NOTE").setStyle(titleStyle).setHorizontalAlignment(HorizontalAlignment.CENTER),
		  Components.text("\n\nPAYMENT INFORMATION").setStyle(titleStyle).setHorizontalAlignment(HorizontalAlignment.RIGHT))
  .newRow()
  ,
  Components.horizontalList()
  .add(
      
		  Components.text(orderHeader.getCustomer().getCustomerName()+"\n"+orderHeader.getCustomer().getStreetNumber()+" "+orderHeader.getCustomer().getStreetName()+"\n"+orderHeader.getCustomer().getCity_town()).setStyle(titleStyle1).setHorizontalAlignment(HorizontalAlignment.LEFT),
		  Components.text(profile.getCompanyName()+"\nREG NO :"+profile.getCompanyRegistration()+"\n"+profile.getStreetName()+","+profile.getStreetNumber()+"\n"+ profile.getCity()+" "+profile.getAreaCode()+"\nTEL : "+profile.getTelephoneNumber()+"\nEMAIL : "+profile.getEmailAdress()).setStyle(titleStyle1).setHorizontalAlignment(HorizontalAlignment.CENTER),
		  Components.text(orderHeader.getCustomer().getCustomerName()+"\n"+orderHeader.getCustomer().getStreetNumber()+" "+orderHeader.getCustomer().getStreetName()+"\n"+orderHeader.getCustomer().getCity_town()).setStyle(titleStyle1).setHorizontalAlignment(HorizontalAlignment.RIGHT))
  .newRow(),
              
  Components.horizontalList()
  .add(
      
		  Components.text("").setHorizontalAlignment(HorizontalAlignment.LEFT),
		  Components.text("").setHorizontalAlignment(HorizontalAlignment.CENTER),
		  Components.text("").setHorizontalAlignment(HorizontalAlignment.RIGHT))
  .newRow()
  
      ).columns(Columns.column("Part Number", "partNumber",DataTypes.stringType()),
              Columns.column("Description", "itemDescription",DataTypes.stringType()),
              Columns.column("Quantity", "quantity",DataTypes.integerType())).setColumnTitleStyle(columnTitleStyle).highlightDetailEvenRows().setDataSource(listItems)
              
              .summary(Components.horizontalList(Components.text("\n\nReceived By ____________________________\n\n\nSignature   ____________________________"),Components.text("\n\nPrint Name & Surname ____________________________\n\n\nDate/Time Received ____________________________\n\n")))
		.summary(Components.horizontalList(Components.text("NOTES ____________________________________________________________________________________")));



		
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

