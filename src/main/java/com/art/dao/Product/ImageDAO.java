package com.art.dao.Product;

import org.springframework.data.jpa.repository.JpaRepository;

import com.art.Entities.Product.Image;

public interface ImageDAO extends JpaRepository<Image, Integer>{

}
