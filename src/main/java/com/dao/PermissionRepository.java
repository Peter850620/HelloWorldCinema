package com.dao;

import com.entity.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PermissionRepository extends JpaRepository<Permission, Permission.CompositeDetail>, JpaSpecificationExecutor<Permission> {

    Permission findByFuncIdAndJobId(Integer funcId, Integer jobId);

    void deleteByFuncIdAndJobId(Integer funcId, Integer jobId);

    List<Permission> findByJobId(Integer jobId);
}
