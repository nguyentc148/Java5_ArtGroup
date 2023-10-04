package com.art.dao.Product;

import org.springframework.data.jpa.repository.JpaRepository;

import com.art.Entities.Product.Manufacturer;

public interface ManufacturerDAO extends JpaRepository<Manufacturer, Integer>{

}
