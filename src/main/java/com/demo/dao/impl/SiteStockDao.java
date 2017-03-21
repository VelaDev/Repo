package com.demo.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SiteStocDaoInt;
import com.demo.model.OrderDetails;
@Repository("siteStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class SiteStockDao implements SiteStocDaoInt {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveSiteStock(List<OrderDetails> detailsDaos) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(detailsDaos);
		} catch (Exception exception) {
			exception.getMessage();

		}
	}
}
