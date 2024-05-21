package com.dao;

import com.entity.Merch;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MerchRepository extends JpaRepository<Merch,Integer> {



    List<Merch> findByMerchStatus(String merchStatus);

}
