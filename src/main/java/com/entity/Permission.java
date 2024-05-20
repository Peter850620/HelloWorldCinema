package com.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

    @Entity
    @Table(name = "permission")
    @IdClass(Permission.CompositeDetail.class)
    public class Permission {

        @Id
        @Column(name = "func_id")
        private Integer funcId;
        @Id
        @Column(name = "job_id")
        private Integer jobId;


        public CompositeDetail getCompositeKey() {
            return new CompositeDetail(funcId, jobId);
        }

        public void setCompositeKey(CompositeDetail key) {
            this.funcId = key.getFuncId();
            this.jobId = key.getJobId();
        }

        public static class CompositeDetail implements Serializable {
            private static final long serialVersionUID = 1L;

            private Integer funcId;
            private Integer jobId;

            // 一定要有無參數建構子
            public CompositeDetail() {
                super();
            }

            public CompositeDetail(Integer funcId, Integer jobId) {
                super();
                this.funcId = funcId;
                this.jobId = jobId;
            }



            public Integer getFuncId() {
                return funcId;
            }

            public void setFuncId(Integer funcId) {
                this.funcId = funcId;
            }

            public Integer getJobId() {
                return jobId;
            }

            public void setJobId(Integer jobId) {
                this.jobId = jobId;
            }


            // 一定要 override 此類別的 hashCode() 與 equals() 方法！
            @Override
            public int hashCode() {
                final int prime = 31;
                int result = 1;
                result = prime * result + ((funcId == null) ? 0 : funcId.hashCode());
                result = prime * result + ((jobId == null) ? 0 : jobId.hashCode());
                return result;
            }

            @Override
            public boolean equals(Object obj) {
                if (this == obj)
                    return true;

                if (obj != null && getClass() == obj.getClass()) {
                    CompositeDetail compositeKey = (CompositeDetail) obj;
                    if (funcId.equals(compositeKey.funcId) && jobId.equals(compositeKey.jobId)) {
                        return true;
                    }
                }

                return false;
            }
        }
    }

