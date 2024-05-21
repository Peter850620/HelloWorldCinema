package com.dao;

import com.entity.Emp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Component
public interface EmpRepository extends JpaRepository<Emp,Integer> {
    @Transactional
    @Modifying
    @Query(value = "delete from emp where emp_id =?", nativeQuery = true)
    void deleteByEmpId(int empId);

    Emp findByEmpId(Integer empId);
//    Optional<User> findByEmail(String empEmail);
}
