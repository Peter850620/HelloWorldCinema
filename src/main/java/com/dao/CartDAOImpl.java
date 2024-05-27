package com.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.entity.Cart;
import com.entity.ShowtimeInfo;
import com.util.HibernateUtil;

public class CartDAOImpl implements CartDAO{

	private SessionFactory factory;

	public CartDAOImpl() {
		factory = HibernateUtil.getSessionFactory();
	}

	private Session getSession() {
		return factory.getCurrentSession();
	}

	//加入商品至購物車
	@Override
	public void addCart(Cart cart) {
		getSession().save(cart);

	}

	//更新購物車裡已有商品
	@Override
	public void updateCartItemQty(Integer memId, Integer merchId, Integer merchQty) {
		 Cart updateCart = getSession().createQuery("FROM Cart WHERE memId = :memId AND merchId = :merchId AND merchQty = :merchQty", Cart.class)
                 .setParameter("memId", memId)
                 .setParameter("merchId", merchId)
                 .setParameter("merchId", merchQty)
                 .uniqueResult();
		 getSession().update(updateCart);
	}

//	移除商品
	@Override
	public void removeItemFromCart(Integer memId, Integer merchId) {
	    // 查找對應的 Cart 項目
	    Cart cartItem = getSession().createQuery("FROM Cart WHERE memId = :memId AND merchId = :merchId", Cart.class)
	                               .setParameter("memId", memId)
	                               .setParameter("merchId", merchId)
	                               .uniqueResult();
	    
	    // 如果找到對應的項目，則將其刪除
	    if (cartItem != null) {
	        getSession().delete(cartItem);
	    }
	}

//	查看購物車
	@Override
	public List<Cart> getCart(Integer memId) {
		List<Cart> cart = getSession()
	            .createQuery("FROM Cart WHERE cart.memId = :memId", Cart.class)
	            .setParameter("memId", memId)
	            .list();
	    return cart;
	}
	
//	訂單成立後刪除購物車
	public void deleteCart(Integer memId) {
	    getSession().createNativeQuery("DELETE FROM cart WHERE memId = :memId")
	            .setParameter("memId", memId)
	            .executeUpdate();
	}
}
