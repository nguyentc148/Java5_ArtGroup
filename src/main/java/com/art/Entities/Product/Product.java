package com.art.Entities.Product;

import com.art.Entities.User.UserCustom;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Product {

	@Id
	private String prodcut_id;
	@Column
	private int price_id;
	@Column
	private int image_id;
	@Column
	private int description_id;
	@Column
	private String product_name;
	@Column
	private int quantity_in_stock;
	@Column
	private boolean is_del;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private UserCustom user;
	
	@ManyToOne
	@JoinColumn(name="category_id")
	private Category category;
	@ManyToOne
	@JoinColumn(name="manufacturer_id")
	private Manufacturer manufacturer;
}
