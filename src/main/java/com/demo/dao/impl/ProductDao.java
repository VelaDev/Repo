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
}
