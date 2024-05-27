package com.dao;

import java.util.List;
import java.util.Set;

import com.entity.Mem;
import com.entity.MerchItem;
import com.entity.MerchOrder;

public interface MerchOrderDAO {

//	public void insert(MerchOrder merchOrder);
	public void insert(MerchOrder merchOrder, Set<MerchItem> merchItems);
	public void update(MerchOrder merchOrder);
	public MerchOrder getByNo(Integer merchNo);
	public List<MerchOrder> getById(Integer memId);
	public MerchOrder getByMobile(String receiptMobile);
	public List<MerchOrder> getAll();


}
