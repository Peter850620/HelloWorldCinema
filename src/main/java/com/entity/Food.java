package com.entity;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.entity.FoodItem;

@Entity
@Table(name = "food")
public class Food {

	@Id
	@Column(name = "food_id", insertable = false, updatable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer foodId;

	@OneToMany(mappedBy = "food")
	private Set<FoodItem> fooditems;

	@Column(name = "food_name", nullable = false)
	private String foodName;

	@Column(name = "food_details")
	private String foodDetails;

	@Column(name = "food_pic", columnDefinition = "mediumblob")
	private byte[] foodPic;

	@Column(name = "food_price", nullable = false)
	private Integer foodPrice;

	@Column(name = "food_status", nullable = false, insertable = false)
	private String foodStatus;

	public Integer getFoodId() {
		return foodId;
	}

	public void setFoodId(Integer foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getFoodDetails() {
		return foodDetails;
	}

	public void setFoodDetails(String foodDetails) {
		this.foodDetails = foodDetails;
	}

	public byte[] getFoodPic() {
		return foodPic;
	}

	public void setFoodPic(byte[] foodPic) {
		this.foodPic = foodPic;
	}

	public Integer getFoodPrice() {
		return foodPrice;
	}

	public void setFoodPrice(Integer foodPrice) {
		this.foodPrice = foodPrice;
	}

	public String getFoodStatus() {
		return foodStatus;
	}

	public void setFoodStatus(String foodStatus) {
		this.foodStatus = foodStatus;
	}

	public Set<FoodItem> getFoods() {
		return fooditems;
	}

	public void setFoods(Set<FoodItem> fooditems) {
		this.fooditems = fooditems;
	}


	@Override
	public String toString() {
		return "Food [food_id=" + foodId + ", food_name=" + foodName + ", food_details=" + foodDetails + ", food_pic=" + foodPic + ", food_price=" + foodPrice
				+ ", food_status=" + foodStatus  + "]";
	}
	
}
