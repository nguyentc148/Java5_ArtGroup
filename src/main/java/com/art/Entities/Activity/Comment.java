package com.art.Entities.Activity;


import java.util.Date;

import com.art.Entities.Product.Product;
import com.art.Entities.User.UserCustom;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
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
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column
	private int star;
	@Column
	private String image;
	@Column
	private String content;
	@Column
	private Date date;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserCustom user;
	@ManyToOne
	@JoinColumn(name = "product_id")
	private Product product;
}
