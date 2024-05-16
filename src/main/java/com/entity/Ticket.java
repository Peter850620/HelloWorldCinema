package com.entity;

import java.math.BigDecimal;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "ticket")
public class Ticket {

 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 @Column(name = "tk_id")
 private Integer tkId;

 @Column(name = "tk_name")
 private String tkName;

 @Column(name = "tk_info")
 private String tkInfo;

 @Column(name = "tk_price")
 private Integer tkPrice;

 @Column(name = "tk_status")
 private String tkStatus;

 public Integer getTkId() {
  return tkId;
 }

 public void setTkId(Integer tkId) {
  this.tkId = tkId;
 }

 public String getTkName() {
  return tkName;
 }

 public void setTkName(String tkName) {
  this.tkName = tkName;
 }

 public String getTkInfo() {
  return tkInfo;
 }

 public void setTkInfo(String tkInfo) {
  this.tkInfo = tkInfo;
 }

 public Integer getTkPrice() {
  return tkPrice;
 }

 public void setTkPrice(Integer tkPrice) {
  this.tkPrice = tkPrice;
 }

 public String getTkStatus() {
  return tkStatus;
 }

 public void setTkStatus(String tkStatus) {
  this.tkStatus = tkStatus;
 }

 @Override
 public String toString() {
  return "Ticket [tk_id=" + tkId + ", tk_name=" + tkName + ", tk_info=" + tkInfo + ", tk_price=" + tkPrice
    + ", tk_status=" + tkStatus + "]";
 }



}
