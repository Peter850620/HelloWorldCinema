package com.dao;

import java.util.List;

import com.entity.MerchItem;

public interface MerchItemDAO {

	public void insert(MerchItem merchItem);
	public void update(MerchItem merchItem);
	public void delete(Integer merchSeq);
	public List<MerchItem> getByNo(Integer merchNo);
	public MerchItem getBySeq(Integer merchSeq);
}
