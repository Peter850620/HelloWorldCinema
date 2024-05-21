package com.service;

import java.util.List;

import javax.transaction.Transactional;

import com.dao.MerchDAO;
import com.dao.MerchDAOImpl;
import com.entity.Merch;
import com.entity.Ticket;


@Transactional
public class MerchServiceYuan {
	
	private MerchDAO dao;

	public MerchServiceYuan() {
		dao = new MerchDAOImpl();
	}

	//單一商品
		public Merch getById(Integer merchId) {
			return dao.getById(merchId);
		}
		
	//上架
		public List<Merch> getByStatus(String merchStatus) {
			return dao.getByStatus(merchStatus);
		}
}
