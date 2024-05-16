package com.entity;

import org.hibernate.annotations.GeneratorType;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "job")
public class Job {

    @Id
    @Column(name = "job_id",nullable = false)
    private Integer jobId;

    @Column(name = "title",length = 4)
    private String title;
    @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER, mappedBy="job")
    private Set<Emp> emps = new HashSet<Emp>();



    public Integer getJobId() {
        return jobId;
    }

    public void setJobId(Integer jobId) {
        this.jobId = jobId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public Set<Emp> getEmps() {
        return emps;
    }

    public void setEmps(Set<Emp> emps) {
        this.emps = emps;
    }

    @Override
    public String toString() {
        return "Job [jobId=" + jobId + ", title=" + title + "]";
    }




}
