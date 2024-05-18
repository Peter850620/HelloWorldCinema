package com.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.entity.RentalOrder;
import com.entity.Mem;

@Repository
public interface RentalOrderRepository extends JpaRepository<RentalOrder, Integer> {
	List<RentalOrder> findRentalOrderByResult(String result);
	List<RentalOrder> findRentalOrderByMem(Mem mem);

  
}
