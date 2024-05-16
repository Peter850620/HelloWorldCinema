package com.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "message")
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "msg_id", updatable = false)
	private Integer msgId;

	@ManyToOne
	@JoinColumn(name = "mem_id", referencedColumnName = "mem_id")
	private Mem mem;

	@Column(name = "msg_title")
	private String msgTitle;

	@Column(name = "msg_detail")
	private String msgDetail;

	@Column(name = "msg_time")
	private Timestamp msgTime;

	@Column(name = "msg_status")
	private String msgStatus;

	public Message() {
		super();
	}

	public Message(Integer msgId, Mem mem, String msgTitle, String msgDetail, Timestamp msgTime, String msgStatus) {
		super();
		this.msgId = msgId;
		this.mem = mem;
		this.msgTitle = msgTitle;
		this.msgDetail = msgDetail;
		this.msgTime = msgTime;
		this.msgStatus = msgStatus;
	}

	public Integer getMsgId() {
		return msgId;
	}

	public void setMsgId(Integer msgId) {
		this.msgId = msgId;
	}

	public Mem getMem() {
		return mem;
	}

	public void setMem(Mem mem) {
		this.mem = mem;
	}

	public String getMsgTitle() {
		return msgTitle;
	}

	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}

	public String getMsgDetail() {
		return msgDetail;
	}

	public void setMsgDetail(String msgDetail) {
		this.msgDetail = msgDetail;
	}

	public Timestamp getMsgTime() {
		return msgTime;
	}

	public void setMsgTime(Timestamp msgTime) {
		this.msgTime = msgTime;
	}

	public String getMsgStatus() {
		return msgStatus;
	}

	public void setMsgStatus(String msgStatus) {
		this.msgStatus = msgStatus;
	}

	@Override
	public String toString() {
		return "Message [msgId=" + msgId + ", mem=" + mem + ", msgTitle=" + msgTitle + ", msgDetail=" + msgDetail
				+ ", msgTime=" + msgTime + ", msgStatus=" + msgStatus + "]";
	}

}
