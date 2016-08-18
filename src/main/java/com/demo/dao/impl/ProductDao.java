package com.demo.dao.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ClientDaoInt;
import com.demo.dao.ProductDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Client;
import com.demo.model.Product;

@Repository("productDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class ProductDao implements ProductDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private ClientDaoInt clientDaoInt;
	@Autowired
	private HttpSession session;
	
	@SuppressWarnings("unused")
	private Date currentDate =null;
	@Override
	public void saveProduct(Product product) {
		
		Client client = (Client) session.getAttribute("client");
		product.setClient(client);
		sessionFactory.getCurrentSession().save(product);
		
	}

	@Override
	public Product getProductBySerialNumbuer(String serialNumber) {
		
		return (Product) sessionFactory.getCurrentSession().get(Product.class, serialNumber);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> getProductList() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
		return (List<Product>)criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> getProductListByClientName(String clientName) {
		ArrayList<Product> productList = null;
		try{
			Client client = null;
			ArrayList<?> aList = new ArrayList<Object>();
		     productList = new ArrayList<Product>();
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
			aList.addAll(criteria.list());
			for (Object pro : aList) {
				if (pro instanceof Product) {
					if (((Product) pro).getClient().getClientName()!=null&&((Product) pro).getClient().getClientName().startsWith(clientName) ) {
						productList.add((Product) pro);
						System.out.println(((Product) pro).getClient().getClientName());
						 client = ((Product) pro).getClient();
					}
				}
			}
			session.setAttribute("client", client);
			
		}
		catch(Exception e){
			return null;
		}
		return productList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accessories> accessories(String serialNumber) {
		ArrayList list = new ArrayList<Accessories>();
		Accessories accessory = new Accessories();
		
		accessory.setBridgeUnitSerial("TTR12");
		accessory.setBridgeUnitSerialType("Bridge Unit");
		accessory.setProd(serialNumber);
		list.add(accessory);
		
		Accessories accessory1 = new Accessories();
		accessory1.setBridgeUnitSerial("CREZ12");
		accessory1.setBridgeUnitSerialType("CREDENZA");
		accessory1.setProd(serialNumber);
		list.add(accessory1);
		
		Accessories accessory2 = new Accessories();
		accessory2.setBridgeUnitSerial("LTC21");
		accessory2.setBridgeUnitSerialType("LTC");
		accessory2.setProd(serialNumber);
		list.add(accessory2);
		
		Accessories accessory3 = new Accessories();
		accessory3.setBridgeUnitSerial("OBT122");
		accessory3.setBridgeUnitSerialType("One Bin Tray");
		accessory3.setProd(serialNumber);
		list.add(accessory3);
		
		Accessories accessory4 = new Accessories();
		accessory4.setBridgeUnitSerial("FU122");
		accessory4.setBridgeUnitSerialType("Fax Unit");
		accessory4.setProd(serialNumber);
		list.add(accessory4);
		
		Accessories accessory5 = new Accessories();
		accessory5.setBridgeUnitSerial("FN122");
		accessory5.setBridgeUnitSerialType("Finisher");
		accessory5.setProd(serialNumber);
		list.add(accessory5);
		
		return list;
	}
	
}
