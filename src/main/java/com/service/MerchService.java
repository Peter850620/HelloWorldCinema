package com.service;


import com.dao.MerchRepository;
import com.entity.Merch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service("merchService")
public class MerchService {

    @Autowired
    MerchRepository merchRepository;

    public void addMerch(Merch merch){
        merchRepository.save(merch);
    }

    public void updateMerch(Merch merch){
        merchRepository.save(merch);
    }

    public void deleteMerch(Integer merchId){
        if(merchRepository.existsById(merchId));
        merchRepository.deleteById(merchId);
    }

    public Merch getbyMerchId(Integer merchId){
        Optional<Merch> optional = merchRepository.findById(merchId);
        return optional.orElse(null);

    }

    public List<Merch> getAll(){
        return merchRepository.findAll();
    }

    public void getbyId(Integer merchId){
        merchRepository.findById(merchId);

    }

    public List<Merch> getbyMerchStatus(String merchStatus){
        return merchRepository.findByMerchStatus(merchStatus);

    }







}
