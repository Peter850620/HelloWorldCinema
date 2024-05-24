package com.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.dao.OrderItemDAO;
import com.dao.OrderItemDAOImpl;
import com.entity.OrderItem;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.service.BookingService;

public class QRCodeGenerator {
	
	//屆時要改專案名
	private static final String BASE_URL = "http:// 10.1.16.53:8081/HelloWorldCinema/QRCodeServlet";  
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
                List<OrderItem> seats = bs.findSeatByBookingNo(10000010);

                OrderItemDAO dao = new OrderItemDAOImpl();

                for (OrderItem orderItem : seats) {
                    String currentSeat = orderItem.getSeatNo();
                    System.out.println("目前座位: " + currentSeat);
                    
                    // 生成 QR Code 要导到的路径
                    String qrText = String.format("%s?bookingNo=%s&showId=%s&seatNo=%s", BASE_URL, "10000010", "9", currentSeat);
                    byte[] qrCodeImage = generateQRCodeImage(qrText, 350, 350);
                    
                    orderItem.setQrcode(qrCodeImage);
                    dao.update(orderItem); // Save the updated orderItem to the database
                }

                transaction.commit();
                System.out.println("QR Codes generated successfully for all seats.");
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

