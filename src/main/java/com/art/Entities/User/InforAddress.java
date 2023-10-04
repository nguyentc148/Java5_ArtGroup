package com.art.Entities.User;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class InforAddress {

	@Id
	private String phone_number;
	@Column
	private String address;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private UserCustom user;
}
