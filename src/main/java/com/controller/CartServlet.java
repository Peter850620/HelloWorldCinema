package com.controller;

import java.util.Collections;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
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


    @PostMapping("/updateCart")
    @ResponseBody
    public String update(@Valid @RequestBody Cart cartItem, BindingResult result, ModelMap model) {
        if (result.hasErrors()) {
            return "Error: Invalid input data";
        }
        try {
            cartService.updateCart(cartItem);
            return "Success: Updated cart";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    @PostMapping("/removeCart")
    @ResponseBody
    public String removeItem(@RequestParam("memId") Integer memId, @RequestParam("merchId") Integer merchId, ModelMap model) {
        try {
            cartService.removeItemFromCart(memId, merchId);
            return "Success: Removed from cart";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    @GetMapping("/cartItems")
    public String getCartItems(@RequestParam Integer memId, Model model) {
        try {
            List<Cart> cartItems = cartService.getCart(memId);
            model.addAttribute("cartItems", cartItems);
            System.out.println(cartItems);
            return "front_end/merch/singleMerch";
        } catch (Exception e) {
            // Handle error, you can log the error here
        	 System.out.println("Error fetching cart items: " + e.getMessage());
            return "/front_end/merch/singleMerch"; // Return to the same page or handle the error accordingly
        }
    }


}
