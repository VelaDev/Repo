package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.ProductDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Employee;
import com.demo.model.Orders;
import com.demo.model.Parts;
import com.demo.model.Product;





@Repository("ordersDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrdersDao implements OrdersDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	@Autowired
	private SparePartsDaoInt sparePartsDaoInt;
	@Autowired
	private ProductDaoInt productDaoInt;
	
	int incrementNo =0;
	
	private String retMessage = null;
	private Employee emp = null;
	private Calendar cal = null;
	private Parts part = null;
	private Product product=null;
	

	@SuppressWarnings("static-access")
	@Override
	public String makeOrder(Orders orders) {
		
		  /* String orderNumber=null;
		   OrderNumGenerator orderNo = null;*/
			
		try{
			
			//orderNo = new OrderNumGenerator();
			String user = (String) session.getAttribute("loggedInUser");
			emp=employeeDaoInt.getEmployeeByEmpNum(user);
			part = sparePartsDaoInt.getSparePartBySerial(orders.getPartP());
			product = productDaoInt.getProductBySerialNumbuer(orders.getProd());
			
			//orderNumber =(String) orderNo.generate(imp, null);
			
			//orderNumber = generateOrderNum();
			//orders.setOrderNum(orderNumber);
			
			orders.setPart(part);
			orders.setEmployee(emp);
			orders.setProduct(product);
			orders.setApproved(false);
			orders.setDateOrdered(cal.getInstance());
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
		try{
			isSpareAvailable = isAvailableSpares(order.getPart().getPartNumber(),order.getQuantity());
			if(isSpareAvailable==true){
				
				order.setApproved(true);
				//order.setDateApproved(dateApproved);
				order.setReceived(true);
				String approvedBy = (String) session.getAttribute("loggedInUser");
				order.setApprodedBy(approvedBy);
				
				sessionFactory.getCurrentSession().update(order);
				retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is updated";
			}else{
				retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is not updated";
			}
		
		}catch (Exception e){
			retMessage = "Order"+" "+ order.getOrderNum()+ " "+"is not updated";
		}
		return retMessage;
	}

	@Override
	public List<Orders> getAllOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Orders> getApprovedOrders() {
		// TODO Auto-generated method stub
		return null;
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
	
	@SuppressWarnings("unused")
	private String generateOrderNum(){
		incrementNo = (int) session.getAttribute("incrementedNo");
		
		if(incrementNo>0){
			
			
		    incrementNo++;
		}
		else{
			incrementNo++;
			
		}
		String lastRecord = lastOrder();
		
		String orderNum ="OD-VEL-0"+incrementNo;
		//session.setAttribute("incrementedNo", incrementNo);
		return orderNum;
	}
	@SuppressWarnings("null")
	private String lastOrder(){
		Orders last = null;
		/*try{
		       Query query =  sessionhibernate.createQuery("from spareorders by ORDER_NUMBER DESC");
		       query.setMaxResults(1);
		       last = (Orders) query.uniqueResult();
		}
		catch(Exception e){
			e.getStackTrace();
		}*/
		return last.getOrderNum();
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

}
