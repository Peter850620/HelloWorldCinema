package com.service;

import com.dao.PermissionRepository;
import com.entity.Permission;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;


@Service("permissionService")
public class PermissionService {

    @Autowired
    private PermissionRepository permissionRepository;

    public List<Permission> getAllPermissions() {
        return permissionRepository.findAll();
    }

    public void addPermission(Permission permissionVO) {
        permissionRepository.save(permissionVO);

    }

    public Permission getdById(Permission.CompositeDetail compositeDetail) {
        return permissionRepository.findById(compositeDetail).orElse(null);
    }

    public void deleteById(Permission.CompositeDetail compositeDetail) {
        permissionRepository.deleteById(compositeDetail);
    }


    public String getPermissionsByJobId(Integer jobId) throws JsonProcessingException {
        List<Permission> jobs = permissionRepository.findByJobId(jobId);
        List<Integer> funIds = new ArrayList<>();
        for (Permission p : jobs) {
            Integer funId = p.getCompositeKey().getFuncId();
            funIds.add(funId);
        }
        ObjectMapper mapper = new ObjectMapper();
        String funcIdsString = mapper.writeValueAsString(funIds);
        String encodedFuncIds = Base64.getEncoder().encodeToString(funcIdsString.getBytes());
        return encodedFuncIds;
    }
}





