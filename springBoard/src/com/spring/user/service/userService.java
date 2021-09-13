package com.spring.user.service;

import java.util.List;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.vo.UserVo;

public interface userService {

	public int idCheck(UserVo userVo) throws Exception;
	
	public List<ComCodeVo> phoneList() throws Exception;
	
	public int userJoin(UserVo userVo) throws Exception;
	
	public UserVo userLogin(UserVo userVo) throws Exception;
	

}
