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

import com.demo.bean.OrdersBean;
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
	private Orders order = null;
	DateFormat dateFormat = null;
	Date date = null;
	
	
	@Override
	public String makeOrder(OrdersBean orders) {
		String orderNumber = null;
		order = new Orders();
			try{
				dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				date = new Date();
				
				String user = (String) session.getAttribute("loggedInUser");
				emp=employeeDaoInt.getEmployeeByEmpNum(user);
				part = sparePartsDaoInt.getSparePartBySerial(orders.getPart());
				device = deviceDaoInt.getDeviceBySerialNumbuer(orders.getDevice());
			
				orderNumber = newOrderNumber();
				order.setOrderNum(orderNumber);
				order.setPart(part);
				order.setEmployee(emp);
				order.setDevice(device);
				order.setApproved(false);
				order.setDateOrdered(dateFormat.format(date));
				order.setDescription(orders.getDescription());
				order.setQuantity(orders.getQuantity());
			
			
			     sessionFactory.getCurrentSession().save(order);
			     retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is created";
		}
		catch(Exception e){
			retMessage = "Order"+" "+ orders.getOrderNum()+ " "+"is not created";
		}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean orders) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String n = " ";
		order = new Orders();
		try{
			
			part= sparePartsDaoInt.getSparePartBySerial(orders.getPart());
			device = deviceDaoInt.getDeviceBySerialNumbuer(orders.getDevice());
			emp =employeeDaoInt.getEmployeeByEmpNum(orders.getEmployee());
			if(part != null){
				order.setApproved(true);
				order.setDateApproved(dateFormat.format(date));
				order.setReceived(true);
				order.setPart(part);
				order.setDevice(device);
				String approvedBy = (String) session.getAttribute("loggedInUser");
				order.setApprodedBy(approvedBy);
				order.setOrderNum(orders.getOrderNum());
				order.setDescription(orders.getDescription());
				order.setQuantity(orders.getQuantity());
				order.setEmployee(emp);
				order.setDateOrdered(orders.getDateOrdered());
				
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
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Orders> getApprovedOrdersByTechnicianName(String userName) {
		
		ArrayList<Orders> aList = new ArrayList<Orders>();
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
	
	private String generateOrderNumber(){
		
		session2=sessionFactory.openSession();
		String result = "";
		Query query = session2.createQuery("from Orders order by orderNum DESC");
		query.setMaxResults(1);
		Orders orderNumber = (Orders) query.uniqueResult();
		
		if(orderNumber != null){
			result = orderNumber.getOrderNum();
		}
		else{
			result = null;
		}
		return result;
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
			newOrderNum = "ORD-VEL-1";
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
