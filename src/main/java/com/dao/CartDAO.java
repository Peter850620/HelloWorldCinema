package com.dao;

import java.util.List;

import com.entity.Cart;

public interface CartDAO {

	public void addCart(Cart cart);
	public void updateCart(Cart updatedCartItem);
	public void removeItemFromCart(Integer memId, Integer merchId);
	public List<Cart> getCart(Integer memId);
}
