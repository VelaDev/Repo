package com.demo.dao.impl;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.Order;
import com.demo.model.OrderDetails;
import com.demo.model.Spare;
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
	@Autowired
	private CustomerDaoInt customerDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	
	private String orderNum ="VEL00";
	
	private String retMessage = null;
	private Customer cus;
	private Employee emp = null;
	private Spare part = null;
	private Device device=null;
	private Order order = null;
	private DateFormat dateFormat = null;
	private Date date = null;
	private List<OrderDetails> orderDetailList = null;
	private OrderDetails orderDetails = null;	
	
	
	@Override
	public String makeOrder(Order order) {
		
			try{
			     sessionFactory.getCurrentSession().save(order);
			     retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is created";
		}
		catch(Exception e){
			retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is not created";
		}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean orders) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String n = " ";
		order = new Order();
		try{
			
			part= sparePartsDaoInt.getSparePartBySerial(orders.getPart());
			device = deviceDaoInt.getDeviceBySerialNumbuer(orders.getDevice());
			emp =employeeDaoInt.getEmployeeByEmpNum(orders.getEmployee());
			if(part != null){
				order.setApproved(true);
				order.setDateApproved(dateFormat.format(date));
				//order.setReceived(true);
				//order.setSpare(part);
				//order.setDevice(device);
				String approvedBy = (String) session.getAttribute("loggedInUser");
				//order.setApprodedBy(approvedBy);
				order.setOrderNum(orders.getOrderNum());
				//order.setDescription(orders.getDescription());
				//order.setQuantity(orders.getQuantity());
				order.setEmployee(emp);
				order.setDateOrdered(orders.getDateOrdered());
				
				sessionFactory.getCurrentSession().update(order);
				retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is approved";
			}else{
				retMessage = "Order"+" "+n+ order.getOrderNum()+ " "+"is not approved because " + " is not available in store." ;
			}
		
		}catch (Exception e){
			retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is not updated " + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public List<Order> getAllOrders() {
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> getApprovedOrdersByTechnicianName(String userName) {
		
		ArrayList<Order> aList = new ArrayList<Order>();
		ArrayList<Order> orderList = new ArrayList<Order>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Order.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Order){
				 if(((Order) order).getEmployee().getEmail().equalsIgnoreCase(userName)&& ((Order)order).isApproved()==true){
					 orderList.add((Order) order);
				 }
			 }
		 }
		return orderList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> getOpenOrders() {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Order> orderList = new ArrayList<Order>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Order.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Order){
				 if(((Order) order).isApproved()==false){
					 orderList.add((Order) order);
				 }
			 }
		 }
		return orderList;
	}

	@Override
	public Order getOrder(String orderNum) {
		
		return (Order) sessionFactory.getCurrentSession().get(Order.class, orderNum);
	}
	
	private String generateOrderNumber(){
		
		session2=sessionFactory.openSession();
		String result = "";
		Query query = session2.createQuery("from Order order by orderNum DESC");
		query.setMaxResults(1);
		Order orderNumber = (Order) query.uniqueResult();
		
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
			tempOrder = newOrderNum.substring(5);
			tempOrderNum = Integer.parseInt(tempOrder)+1;
			newOrderNum = orderNum+ tempOrderNum;
		}
		else{
			newOrderNum = "VEL001";
		}
		
		return newOrderNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> getAllOrders(String orderedBy) {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Order> orderList = new ArrayList<Order>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Order.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof Order){
				 if(((Order) order).getEmployee().getEmail().equalsIgnoreCase(orderedBy)){
					 orderList.add((Order) order);
				 }
			 }
		 }
		return orderList;
	}

	@Override
	public String prepareOrderMaking(OrdersBean orderBean) {
		orderDetailList = new ArrayList<OrderDetails>();
		
		order = new Order();
		String orderNumber = null;
		 String[] split;
		 String partNumber,modelNumber,description,splitString = null;
		 int quatity = 0;
	
		 dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			date = new Date();
		String[] quantityArray = quantity(orderBean.getQuantity(),orderBean.getSelectedItem().length);
		
		try{
			
			Employee user = (Employee) session.getAttribute("loggedInUser");
			emp=employeeDaoInt.getEmployeeByEmpNum(user.getEmail());
			String customer = orderBean.getCustomer();
			cus = customerDaoInt.getClientByClientName(customer);
			order.setCustomer(cus);
			order.setStockType(orderBean.getStockType());
			order.setStatus("Pending");
			order.setApprover(orderBean.getApprover());
			
			
			
		
			orderNumber = newOrderNumber();
			order.setOrderNum(orderNumber);
			//order.setSpare(part);
			order.setEmployee(emp);
			//order.setDevice(device);
			order.setApproved(false);
			order.setDateOrdered(dateFormat.format(date));
			//order.setDescription(orders.getDescription());
			//order.setQuantity(orders.getQuantity());
		
              			
			  for(int i=0; i<orderBean.getSelectedItem().length;i++){
				  orderDetails = new OrderDetails();
				  splitString = orderBean.getSelectedItem()[i];
				  split = splitString.split(",");
				  partNumber = split[0];
				  modelNumber=split[1];
				  description = split[2];
				  part = sparePartsDaoInt.getSparePartBySerial(partNumber);
				  quatity = Integer.parseInt(quantityArray[i]);
				  orderDetails.setPartNumber(partNumber);
				  orderDetails.setDescription(description);
				  orderDetails.setModel(modelNumber);
				  orderDetails.setQuantity(quatity);
				  orderDetails.setLocation(orderBean.getLocation());
				  orderDetails.setStockType(part.getStockType());
				  orderDetails.setTechnician(orderBean.getTechnician());
				  orderDetails.setOrder(order);
				  orderDetails.setDateTime(dateFormat.format(date));
				  
				  orderDetailList.add(orderDetails);
			  }
			  
			  
			  retMessage = makeOrder(order);
			  String retMsg = detailsDaoInt.saveOrderDetails(orderDetailList);
		}catch(Exception ex){
			retMessage = " Order cannot be proccessed "+ ex.getMessage();
		}
		return retMessage;
	}

	private String[] quantity(String[] arr, int length)
    {
    	String[] newQuantity =new String[length];
    	int x =0;
    	for(int i=0; i<arr.length; i++)
    	{
    		if(arr[i]!=""){
    			newQuantity[x] =arr[i];
    			x++;
    		}
    	}
	  return newQuantity;
	
    }
}
