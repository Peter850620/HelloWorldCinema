package com.dao;

import com.entity.Func;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FuncRepository extends JpaRepository<Func,Integer> {

}
