package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.entity.Cart;

import redis.clients.jedis.Jedis;

public class CartServiceTest {

    public static void main(String[] args) {
        Jedis jedis = new Jedis("localhost", 6379);

//        // 添加第一筆商品到購物車
//        HashMap<String, String> data1 = new HashMap<>();
//        data1.put("memId", "240001");
//        data1.put("merchId", "1");
//        data1.put("merchName", "螢火蟲之墓迷你拼圖");
//        data1.put("merchQty", "1");
//        data1.put("merchPrice", "100");
//
//        jedis.hmset("cart:240001:1", data1);
//
//        // 添加第二筆商品到購物車
//        HashMap<String, String> data2 = new HashMap<>();
//        data2.put("memId", "240001");
//        data2.put("merchId", "2");
//        data2.put("merchName", "[珍藏版]水行俠夜光潛水腕錶 藍黑蜂巢紋-鋼鍊帶黑");
//        data2.put("merchQty", "1");
//        data2.put("merchPrice", "50");
//
//        jedis.hmset("cart:240001:2", data2);
//
//        // 檢查第一筆購物車中的商品
//        List<String> cartData1 = jedis.hmget("cart:240001:1", "memId", "merchId", "merchName", "merchQty", "merchPrice");
//        System.out.println("Initial HMGET for cart:240001:1: ");
//        for (String str : cartData1)
//            System.out.println(str);
//
//        // 檢查第二筆購物車中的商品
//        List<String> cartData2 = jedis.hmget("cart:240001:2", "memId", "merchId", "merchName", "merchQty", "merchPrice");
//        System.out.println("Initial HMGET for cart:240001:2: ");
//        for (String str : cartData2)
//            System.out.println(str);
//
//        // 更新第一筆購物車中的商品
//        Map<String, String> updatedData1 = new HashMap<>();
//        updatedData1.put("memId", "240001");
//        updatedData1.put("merchId", "1");
//        updatedData1.put("merchName", "螢火蟲之墓迷你拼圖");
//        updatedData1.put("merchQty", "2"); // 更新數量
//        updatedData1.put("merchPrice", "50");
//
//        jedis.hmset("cart:240001:1", updatedData1);
//
//        // 更新第二筆購物車中的商品
//        Map<String, String> updatedData2 = new HashMap<>();
//        updatedData2.put("memId", "240001");
//        updatedData2.put("merchId", "2");
//        updatedData2.put("merchName", "[珍藏版]水行俠夜光潛水腕錶 藍黑蜂巢紋-鋼鍊帶黑");
//        updatedData2.put("merchQty", "3"); // 更新數量
//        updatedData2.put("merchPrice", "200");
//
//        jedis.hmset("cart:240001:2", updatedData2);
//
//        // 檢查更新後的第一筆購物車商品
//        List<String> updatedCartData1 = jedis.hmget("cart:240001:1", "memId", "merchId", "merchName", "merchQty", "merchPrice");
//        System.out.println("Updated HMGET for cart:240001:1: ");
//        for (String str : updatedCartData1)
//            System.out.println(str);
//
//        // 檢查更新後的第二筆購物車商品
//        List<String> updatedCartData2 = jedis.hmget("cart:240001:2", "memId", "merchId", "merchName", "merchQty", "merchPrice");
//        System.out.println("Updated HMGET for cart:240001:2: ");
//        for (String str : updatedCartData2)
//            System.out.println(str);
//
//        // 移除第一筆購物車中的商品
//        jedis.del("cart:240001:1");
//
//        // 檢查移除後的第一筆購物車商品
//        List<String> removedCartData1 = jedis.hmget("cart:240001:1", "memId", "merchId", "merchName", "merchQty", "merchPrice");
//        System.out.println("HMGET for removed cart:240001:1: ");
//        for (String str : removedCartData1)
//            System.out.println(str);
        
        CartService cartService = new CartService();
        List<Cart> cartList = cartService.getCart(240002);
        System.out.println(cartList);
        
        // 清理測試數據
//        jedis.del("cart:240001:1");
//        jedis.del("cart:240001:2");

        jedis.close();
    }
}
