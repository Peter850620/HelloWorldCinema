package com.dao;

import com.entity.Mem;

public interface MemDAO {
	
	public Mem getByEmail(String memEmail);
	
	public Mem findMem(Integer memId);

}
