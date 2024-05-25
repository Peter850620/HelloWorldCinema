package com.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import com.dao.MerchOrderDAO;
import com.dao.MerchOrderDAOImpl;
import com.entity.Mem;
import com.entity.Merch;
import com.entity.MerchItem;
import com.entity.MerchOrder;
import com.entity.Ticket;

public class MerchOrderService {

    private MerchOrderDAO dao;

    public MerchOrderService() {
        dao = new MerchOrderDAOImpl();
    }
    
//	新增商品訂單
	public MerchOrder addMerchOrder(Mem mem, Date orderDate, String pickupOption, String paymentType,
			String receiptStatus, Integer merchTotal, String recipient, String receiptAddr, String receiptMobile) {
		
		MerchOrder merchOrder = new MerchOrder();
		

		merchOrder.setMem(mem);
		merchOrder.setOrderDate(new Date());
		merchOrder.setPickupOption(pickupOption);
		merchOrder.setPaymentType(paymentType);
		merchOrder.setReceiptStatus(receiptStatus);
		merchOrder.setMerchTotal(merchTotal);
		merchOrder.setRecipient(recipient);
		merchOrder.setReceiptAddr(receiptAddr);
		merchOrder.setReceiptMobile(receiptMobile);
		
		dao.insert(merchOrder);
		
		return merchOrder;
	}
    
  //修改單一訂單
  	public MerchOrder getOneMerchOrder(Integer merchNo) {
  		return dao.getByNo(merchNo);
  	}

    // 修改訂單
    public MerchOrder updateMerchOrder(Integer merchNo, String pickupOption, String paymentType,
            String receiptStatus, String recipient, String receiptAddr, String receiptMobile) {
        MerchOrder merchOrder = dao.getByNo(merchNo);

        if (merchOrder != null) {
            merchOrder.setPickupOption(pickupOption);
            merchOrder.setPaymentType(paymentType);
            merchOrder.setReceiptStatus(receiptStatus);
            merchOrder.setRecipient(recipient);
            merchOrder.setReceiptAddr(receiptAddr);
            merchOrder.setReceiptMobile(receiptMobile);

            dao.update(merchOrder);
        }

        return merchOrder;
    }

    // 查詢訂單編號
    public MerchOrder getByNo(Integer merchNo) {
        return dao.getByNo(merchNo);
    }

    // 查詢會員編號
    public List<MerchOrder> getById(Integer memId) {
        return dao.getById(memId);
    }

    

    // 查詢收件電話
    public MerchOrder getByMobile(String receiptMobile) {
        return dao.getByMobile(receiptMobile);
    }

    // 查詢所有訂單
    public List<MerchOrder> getAll() {
        return dao.getAll();
    }
}
