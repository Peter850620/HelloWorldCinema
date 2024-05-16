package com.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;



@Entity
@Table(name = "screen")
public class Screen {

 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 @Column(name = "screen_id",updatable = false)
 private String screenId;
 
 @Column(name = "capacity")
 private Integer capaCity;
 
 @Column(name = "screen_info")
 private String screenInfo;
 
 @Column(name = "length")
 private Integer length;
 
 @Column(name = "width")
 private Integer width;
 
 @Column(name = "seat_no")
 private String seatNo;
 
 @Column(name = "price")
 private Integer price;
 
 @Column(name = "deposit")
 private Integer deposit;
 
 @Override
 public String toString() {
  return "Ticket [screen_id=" + screenId + ", capacity=" + capaCity + ", screen_info=" + screenInfo + ", length=" + length
    + ", width=" + width + ", seat_no=" + seatNo + ", price=" + price + ", deposit=" + deposit + "]";
 }
 
 public String getScreenId() {
  return screenId;
 }

 public void setScreenId(String screenId) {
  this.screenId = screenId;
 }

 public Integer getCapaCity() {
  return capaCity;
 }

 public void setCapaCity(Integer capaCity) {
  this.capaCity = capaCity;
 }

 public String getScreenInfo() {
  return screenInfo;
 }

 public void setScreenInfo(String screenInfo) {
  this.screenInfo = screenInfo;
 }

 public Integer getLength() {
  return length;
 }

 public void setLength(Integer length) {
  this.length = length;
 }

 public Integer getWidth() {
  return width;
 }

 public void setWidth(Integer width) {
  this.width = width;
 }

 public String getSeatNo() {
  return seatNo;
 }

 public void setSeatNo(String seatNo) {
  this.seatNo = seatNo;
 }

 public Integer getPrice() {
  return price;
 }

 public void setPrice(Integer price) {
  this.price = price;
 }

 public Integer getDeposit() {
  return deposit;
 }

 public void setDeposit(Integer deposit) {
  this.deposit = deposit;
 }

 

 
 
// @OneToMany
// @JoinColumn(name = "screen_id", referencedColumnName = "screen_id")
// private RentalOrder rentalOrder;
//
// public RentalOrder getRentalOrder() {
//  return rentalOrder;
// }
//
// public void setRentalOrder(RentalOrder rentalOrder) {
//  this.rentalOrder = rentalOrder;
// }
 
}