







package com.entity;


import groovy.transform.ToString;
import jdk.jfr.DataAmount;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.hibernate.proxy.HibernateProxy;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "func")
@Getter
@Setter
@ToString
public class Func{

    @Id
    @Column(name = "func_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer funcId;

    @Column(name = "func",nullable = false,length = 10)
    private String func;

    @Column(name = "func_detail",length = 255)
    private String funcDetail;




    public Func() {
    }

    public Integer getFuncId() {
        return funcId;
    }

    public void setFuncId(Integer funcId) {
        this.funcId = funcId;
    }

    public String getFunc() {
        return func;
    }

    public void setFunc(String func) {
        this.func = func;
    }

    public String getFuncDetail() {
        return funcDetail;
    }

    public void setFuncDetail(String funcDetail) {
        this.funcDetail = funcDetail;
    }

    @Override
    public String toString() {
        return "Func [funcId=" + funcId + ", func=" + func + ", funcDetail=" + funcDetail + "]";
    }


    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        Func func = (Func) o;
        return getFuncId() != null && Objects.equals(getFuncId(), func.getFuncId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}