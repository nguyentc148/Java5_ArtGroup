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
public class UserCustom {

	@Id
	private String user_id;

	@ManyToOne
	@JoinColumn(name = "user_custom")
	private Role role_name;
	@Column
	private String fullname;
	@Column
	private String image;
	@Column
	private String password;

	@Column
	private String email;
	@Column
	private boolean is_del;
}
