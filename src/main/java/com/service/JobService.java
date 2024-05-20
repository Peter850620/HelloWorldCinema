package com.service;

import com.dao.JobRepository;
import com.entity.Emp;
import com.entity.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service("jobsevice")
@Component
public class JobService {
    @Autowired
    JobRepository repository;

    public void addJob(Job jobVO){
        repository.save(jobVO);
    }
    public void updateJob(Job jobVO){
        repository.save(jobVO);
    }
    public void deleteJob(Integer JobId){
        repository.deleteById(JobId);
    }

    public Job getById(Integer JobId){
        Optional<Job> optioinal = repository.findById(JobId);
        return optioinal.orElse(null);
    }

    public List<Job> getAll(){
        return repository.findAll();
    }

    public Set<Emp> getEmpsByJobId(Integer jobId){
        Set<Emp> emps = getById(jobId).getEmps();
        return emps;
    }


}
