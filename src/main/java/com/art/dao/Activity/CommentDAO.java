package com.art.dao.Activity;

import org.springframework.data.jpa.repository.JpaRepository;

import com.art.Entities.Activity.Comment;

public interface CommentDAO extends JpaRepository<Comment, Integer> {

}
