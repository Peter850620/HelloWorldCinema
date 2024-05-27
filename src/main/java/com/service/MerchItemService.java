package com.service;

import java.util.List;

import com.dao.MerchItemDAO;
import com.dao.MerchItemDAOImpl;
import com.entity.Merch;
import com.entity.MerchItem;
import com.entity.MerchOrder;

public class MerchItemService {

	private MerchItemDAO dao;
	
	public MerchItemService() {
		dao = new MerchItemDAOImpl();
	}

//	<==============================前台===============================>
	
//	列出商品明細
	public List<MerchItem> showByNo(Integer merchNo) {
		return dao.getByNo(merchNo);
	}

//	<==============================後台===============================>
    
//	更新商品明細
	public MerchItem updateMerchItem(Integer merchSeq, MerchOrder merchNo, Merch merchId, Integer merchQty, Integer merchSubTotal) {
		
		MerchItem merchItem = new MerchItem();
		
		merchItem.setMerchSeq(merchSeq);
		merchItem.setMerchOrder(merchNo);
		merchItem.setMerch(merchId);
		merchItem.setMerchQty(merchQty);
		merchItem.setMerchSubTotal(merchSubTotal);
		
		dao.update(merchItem);
		
		return merchItem;
	}
//	刪除商品明細
	public void deleteMerchItem(Integer merchSeq) {
		dao.delete(merchSeq);
	}
//	修改單一明細
	public MerchItem getOneMerchItem(Integer merchSeq) {
		return dao.getBySeq(merchSeq);
	}
//	查詢訂單編號
	public List<MerchItem> getByNo(Integer merchNo) {
		return dao.getByNo(merchNo);
	}
}
