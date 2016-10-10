package com.demo.dao.impl;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Employee;
import com.demo.model.Orders;
import com.demo.model.Parts;
import com.demo.model.Device;





@Repository("ordersDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrdersDao implements OrdersDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	private Session session2;
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	@Autowired
	private SparePartsDaoInt sparePartsDaoInt;
	@Autowired
	private DeviceDaoInt deviceDaoInt;
	
	private String orderNum ="ORD-VEL-";
	
	private String retMessage = null;
	private Employee emp = null;
	private Calendar cal = null;
	private Parts part = null;
	private Device device=null;
	DateFormat dateFormat = null;
	Date date = null;
	
	

	@SuppressWarnings("static-access")
	@Override
	public String makeOrder(Orders orders) {
		String orderNumber = null;
			try{
				dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				date = new Date();
			String user = (String) session.getAttribute("loggedInUser");
			emp=employeeDaoInt.getEmployeeByEmpNum(user);
			part = sparePartsDaoInt.getSparePartBySerial(orders.getPartP());
			device = deviceDaoInt.getProductBySerialNumbuer(orders.getProd());
			
			orderNumber = newOrderNumber();
			orders.setOrderNum(orderNumber);
			orders.setPart(part);
			orders.setEmployee(emp);
			orders.setProduct(device);
			orders.setApproved(false);
			orders.setDateOrdered(dateFormat.format(date));
			  sessionFactory.getCurrentSession().save(orders);
			  retMessage = "Order"+" "+ orders.getOrderNum()+ " "+"is created";
		}
		catch(Exception e){
			retMessage = "Order"+" "+ orders.getOrderNum()+ " "+"is not created";
		}
		return retMessage;
	}

	@Override
	public String updateOrder(Orders order) {
		boolean isSpareAvailable;
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String n = " ";
		try{
			/*isSpareAvailable = isAvailableSpares(order.getPartP(),order.getQuantity());*/
			/*if(isSpareAvailable==true){*/
			part= sparePartsDaoInt.getSparePartBySerial(order.getPartP());
			device = deviceDaoInt.getProductBySerialNumbuer(order.getProd());
			if(part != null){
				order.setApproved(true);
				order.setDateApproved(dateFormat.format(date));
				order.setReceived(true);
				order.setPart(part);
				order.setProduct(device);
				String approvedBy = (String) session.getAttribute("loggedInUser");
				order.setApprodedBy(approvedBy);
				
				sessionFactory.getCurrentSession().update(order);
				retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is approved";
			}else{
				retMessage = "Order"+" "+n+ order.getOrderNum()+ " "+"is not approved because " + order.getPart().getItemType()+ " is not available in store." ;
			}
		
		}catch (Exception e){
			retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is not updated " + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public List<Orders> getAllOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getApprovedOrdersByTechnicianName(String userName) {
		
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Orders> orderList = new ArrayList<Orders>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Orders.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Orders){
				 if(((Orders) order).getEmployee().getUsername().equalsIgnoreCase(userName)&& ((Orders)order).isApproved()==true){
					 orderList.add((Orders) order);
				 }
			 }
		 }
		return orderList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getOpenOrders() {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Orders> orderList = new ArrayList<Orders>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Orders.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Orders){
				 if(((Orders) order).isApproved()==false){
					 orderList.add((Orders) order);
				 }
			 }
		 }
		return orderList;
	}

	@Override
	public Orders getOrder(String orderNum) {
		
		return (Orders) sessionFactory.getCurrentSession().get(Orders.class, orderNum);
	}
	private boolean isAvailableSpares(String serialNum,int quantity)
	{
		boolean retFlag = false;
		Parts parts = null;
		int tempQuantity;
		try{
			
			 parts= sparePartsDaoInt.getSparePartBySerial(serialNum);
			 
			 if(quantity <= parts.getQuantity()){
				 retFlag = true;
				 tempQuantity = parts.getQuantity()-quantity;
				 parts.setQuantity(tempQuantity);
				 sparePartsDaoInt.updateSpareParts(parts);
			 }
		}
		catch(Exception e){
			retFlag=false;
		}
		return retFlag;
	}
	
	private String generateOrderNumber(){
		
		session2=sessionFactory.openSession();
		
		Query query = session2.createQuery("from Orders order by orderNum DESC");
		query.setMaxResults(1);
		Orders orderNumber = (Orders) query.uniqueResult();
		return orderNumber.getOrderNum();
	}
	private String newOrderNumber(){
		String tempOrder = "";
		int tempOrderNum = 0;
		String newOrderNum = generateOrderNumber();
		
		if (newOrderNum != null){
			tempOrder = newOrderNum.substring(8);
			tempOrderNum = Integer.parseInt(tempOrder)+1;
			newOrderNum = orderNum+ tempOrderNum;
		}
		else{
			orderNum = "ORD-VEL-1";
		}
		
		return newOrderNum;
	}

	@Override
	public List<Orders> getAllOrders(String orderedBy) {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Orders> orderList = new ArrayList<Orders>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Orders.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Orders){
				 if(((Orders) order).getEmployee().getUsername().equalsIgnoreCase(orderedBy)){
					 orderList.add((Orders) order);
				 }
			 }
		 }
		return orderList;
	}


}
