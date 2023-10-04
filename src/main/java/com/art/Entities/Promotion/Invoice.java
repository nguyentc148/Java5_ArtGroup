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
public class Invoice {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int invoice_id;

	@ManyToOne
	@JoinColumn(name="user_id")
	private UserCustom user;

	@Column
	private Date invoice_date;

	@Column
	private double total_amount;

	@Column
	private String description;

	@OneToMany(mappedBy = "invoice", cascade = CascadeType.ALL)
	private List<InvoiceDetail> invoiceDetails;
}
