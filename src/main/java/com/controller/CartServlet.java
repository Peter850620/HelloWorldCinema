package com.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Cart;
import com.service.CartService;

@Controller
@RequestMapping("/merch/cart")
public class CartServlet {

    @Autowired
    private CartService cartService;

    @PostMapping("/insert")
    @ResponseBody
    public String insert(@Valid @RequestBody Cart cart) {
        try {
            cartService.addCart(cart);
            return "Success: Added to cart";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }


    @PostMapping("/updateQty")
    @ResponseBody
    public Map<String, String> updateQuantity(@RequestParam("memId") Integer memId,@RequestParam("merchId") Integer merchId,@RequestParam("newQty") Integer merchQty) {
    	Map<String, String> response = new HashMap<>();
        try {
            cartService.updateCartItemQuantity(memId, merchId, merchQty);
            response.put("status", "Success");
            response.put("message", "update from cart");
        } catch (Exception e) {
        	response.put("status", "Error");
            response.put("message", e.getMessage());
        
        }
		return response;
    }


    @PostMapping("/removeCart")
    @ResponseBody
    public Map<String, String> removeItem(@RequestParam("memId") Integer memId, @RequestParam("merchId") Integer merchId) {
        Map<String, String> response = new HashMap<>();
        if (memId == null || merchId == null) {
            response.put("status", "Error");
            response.put("message", "memId and merchId are required");
        } else {
            try {
                cartService.removeItemFromCart(memId, merchId);
                response.put("status", "Success");
                response.put("message", "Removed from cart");
            } catch (Exception e) {
                response.put("status", "Error");
                response.put("message", e.getMessage());
            }
        }
        return response;
    }

    @GetMapping("/cartItems")
    @ResponseBody
    public List<Cart> getCartItems(@RequestParam Integer memId) {
        System.out.println("Fetching cart items for memId: " + memId);
        try {
            List<Cart> cartItems = cartService.getCart(memId);
            System.out.println("Cart items fetched: " + cartItems);
            return cartItems;
        } catch (Exception e) {
            System.out.println("Error fetching cart items: " + e.getMessage());
            return Collections.emptyList(); // Returning empty list in case of error
        }
    }
    



}
