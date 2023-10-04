package com.art.Entities.Promotion;

import java.util.Date;
import java.util.List;

import com.art.Entities.User.UserCustom;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class FlashSale {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int flashSale_id;

	@Column
	private Date start_day;
	
	@Column
	private Date end_day;

	@Column
	private boolean is_status;

	@OneToMany(mappedBy = "flashSale", cascade = CascadeType.ALL)
	private List<PromotionalDetails> promotionalDetailsList;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private UserCustom user;

}
