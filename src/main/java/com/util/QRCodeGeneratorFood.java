package com.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.dao.FoodItemDAO;
import com.dao.FoodItemIDAOmpl;
import com.entity.FoodItem;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.service.BookingService;

public class QRCodeGeneratorFood {

	
	//屆時要改專案名
	private static final String BASE_URL = "http://helloworldcinema.ddns.net:8081/HelloWorldCinema/QRCodeFoodServlet"; 
//	private static final String BASE_URL = "http://localhost:8081/HelloWorldCinema/QRCodeFoodServlet";  
    BookingService bs=new BookingService();
    
    
    public static byte[] generateQRCodeImage(String text, int width, int height) throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

        ByteArrayOutputStream os = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "JPG", os);
        return os.toByteArray();
    }

   
       

        public static void main(String[] args) {
            Session session = null;
            Transaction transaction = null;

            try {
                session = HibernateUtil.getSessionFactory().getCurrentSession();
                transaction = session.beginTransaction();
                
                BookingService bs = new BookingService();
                List<FoodItem> foodItemdata = bs.getFoodbyBookingNo(10000010);

                FoodItemDAO dao = new FoodItemIDAOmpl();

                // 构建包含所有食品信息的文本字符串
                StringBuilder foodInfoBuilder = new StringBuilder();
                Integer bookingNo = null;
                for (FoodItem foodItem : foodItemdata) {
                	bookingNo = foodItem.getBooking().getBookingNo();
                    String foodName = foodItem.getFood().getFoodName();
                    System.out.println("餐點名稱: " + foodName);
					
                    Integer foodAmount = foodItem.getFoodAmount();
                    System.out.println("餐點數量: " + foodAmount);
                    
                    // 将每个食品信息添加到字符串中
                    foodInfoBuilder.append(String.format("%s - %d, ", foodName, foodAmount));
                }    
                    // 删除最后一个逗号
                    foodInfoBuilder.deleteCharAt(foodInfoBuilder.length() - 2);
                    
                    // 生成 QR Code 要导到的路径
                    String qrText = String.format("%s?bookingNo=%s", BASE_URL, bookingNo);
                    System.out.println(qrText);
                    byte[] qrCodeImage = generateQRCodeImage(qrText, 350, 350);
                    
                    for (FoodItem foodItem : foodItemdata) {
	                    foodItem.setQrcode(qrCodeImage);
	                    dao.update(foodItem); // Save the updated orderItem to the database
                    }

                transaction.commit();
                System.out.println("QR Codes generated successfully for all foodItem.");
            } catch (Exception e) {
                if (transaction != null) {
                    transaction.rollback();
                }
                e.printStackTrace();
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }    
    }
}
