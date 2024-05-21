package com.dao;

import java.util.List;

import com.entity.Merch;


public interface MerchDAO {
	public Merch getById(Integer merchId);
	public List<Merch> getByStatus(String merchStatus);
}
