package com.dao;

import java.util.List;
import java.util.Set;

import com.entity.MerchItem;

public interface MerchItemDAO {

	public void insert(Set<MerchItem> merchItems);
	public void update(MerchItem merchItem);
	public void delete(Integer merchSeq);
	public List<MerchItem> getByNo(Integer merchNo);
	public MerchItem getBySeq(Integer merchSeq);
}
