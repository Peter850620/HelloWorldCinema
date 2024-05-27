package com.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.CartDAO;
import com.dao.CartDAOImpl;
import com.entity.Cart;
import com.util.JedisUtil;

import redis.clients.jedis.Jedis;

@Service("CartService")
public class CartService {

    private CartDAO dao;

    @Autowired
    private JedisUtil jedisUtil;

    public CartService() {
        dao = new CartDAOImpl();
    }

    // 將加入購物車的商品存入 Redis
    public void addCart(Cart cart) {
        try (Jedis jedis = jedisUtil.getJedisPool().getResource()) {
            String cartKey = cart.getRedisKey();
            Map<String, String> cartData = jedis.hgetAll(cartKey);
            if (cartData != null && !cartData.isEmpty()) {
                // 商品已存在於購物車中，增加數量
                int currentQty = Integer.parseInt(cartData.get("merchQty"));
                int newQty = currentQty + cart.getMerchQty();
                jedis.hset(cartKey, "merchQty", String.valueOf(newQty));
                System.out.println("Item quantity increased in cart: " + cart.getMerchName());
            } else {
                // 商品不存在於購物車中，新增商品
                Map<String, String> newCartData = new HashMap<>();
                newCartData.put("memId", String.valueOf(cart.getMemId()));
                newCartData.put("merchId", String.valueOf(cart.getMerchId()));
                newCartData.put("merchName", cart.getMerchName());
                newCartData.put("merchQty", String.valueOf(cart.getMerchQty()));
                newCartData.put("merchPrice", String.valueOf(cart.getMerchPrice()));
                jedis.hmset(cartKey, newCartData);
                System.out.println("Item added to cart: " + cart.getMerchName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    查看購物車
    public List<Cart> getCart(Integer memId) {
        List<Cart> cartList = new ArrayList<>();

        try (Jedis jedis = jedisUtil.getJedisPool().getResource()) {
            // 假設每個商品都有一個獨立的鍵
            Set<String> cartKeys = jedis.keys("cart:" + memId + ":*");

            for (String cartKey : cartKeys) {
                Map<String, String> cartData = jedis.hgetAll(cartKey);

                if (cartData != null && !cartData.isEmpty()) {
                    Integer merchId = Integer.parseInt(cartData.get("merchId"));
                    Cart cart = new Cart(memId, merchId, cartData.get("merchName"),
                            Integer.parseInt(cartData.get("merchQty")), Integer.parseInt(cartData.get("merchPrice")));
                    cartList.add(cart);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartList;
    }


 // 修改購物車中的商品數量
    public void updateCartItemQty(Integer memId, Integer merchId, Integer merchQty) {
        try (Jedis jedis = jedisUtil.getJedisPool().getResource()) {
            String cartKey = "cart:" + memId + ":" + merchId;
            Map<String, String> cartData = jedis.hgetAll(cartKey);

            if (cartData != null && !cartData.isEmpty()) {
                // 更新商品數量
                jedis.hset(cartKey, "merchQty", String.valueOf(merchQty));
                System.out.println("Item quantity updated in cart: " + merchId);
            } else {
                System.out.println("Cart not found for memId: " + memId + ", merchId: " + merchId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // 從購物車中移除商品
    public void removeItemFromCart(Integer memId, Integer merchId) {
        try (Jedis jedis = jedisUtil.getJedisPool().getResource()) {
            String cartKey = "cart:" + memId + ":" + merchId;
            if (jedis.exists(cartKey)) {
                jedis.del(cartKey);
                System.out.println("Item removed from cart: " + merchId);
            } else {
                System.out.println("Cart not found for memId: " + memId + ", merchId: " + merchId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //訂單成立後移除購物車
    public void deleteCart(Integer memId) {
        try (Jedis jedis = jedisUtil.getJedisPool().getResource()) {
            // Assuming cart keys are stored with a specific pattern, e.g., "cart:memId:*"
            Set<String> cartKeys = jedis.keys("cart:" + memId + ":*");
            for (String cartKey : cartKeys) {
                jedis.del(cartKey); // Delete each cart item
            }
            System.out.println("Cart deleted for memId: " + memId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
