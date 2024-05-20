package com.service;

import com.dao.PermissionRepository;
import com.entity.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("permissionService")
public class PermissionService {

    @Autowired
    private PermissionRepository permissionRepository;

    public List<Permission> getAllPermissions() {
        return permissionRepository.findAll();
    }

    public void addPermission(Permission permissionVO){
        permissionRepository.save(permissionVO);

    }

    public Permission getdById(Permission.CompositeDetail compositeDetail) {
        return permissionRepository.findById(compositeDetail).orElse(null);
    }

    public void deleteById(Permission.CompositeDetail compositeDetail) {
        permissionRepository.deleteById(compositeDetail);
    }




}





