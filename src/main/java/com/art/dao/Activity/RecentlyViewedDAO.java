package com.art.dao.Activity;

import org.springframework.data.jpa.repository.JpaRepository;

import com.art.Entities.Activity.RecentlyViewed;

public interface RecentlyViewedDAO extends JpaRepository<RecentlyViewed, Integer> {

}
