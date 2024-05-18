package com.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.entity.Mem;

@Repository
public interface MemRepository extends JpaRepository<Mem, Integer>{
	Mem findByMemId(Integer memId);
	Mem findByMemAcount(String memAcount);
	Mem findByMemEmail(String memEmail);
	List<Mem> findByMemStatus(String memStatus);
}
