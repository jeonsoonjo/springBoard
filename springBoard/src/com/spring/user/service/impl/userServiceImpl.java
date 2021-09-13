package com.spring.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.dao.UserDao;
import com.spring.user.service.userService;
import com.spring.user.vo.UserVo;

@Service
public class userServiceImpl implements userService{
	
	@Autowired
	UserDao userDao;

	@Override
	public int idCheck(UserVo userVo) throws Exception {
		int result = userDao.idCheck(userVo);
		return result;
	}

	@Override
	public List<ComCodeVo> phoneList() throws Exception {
		return userDao.phoneList();
	}

	@Override
	public int userJoin(UserVo userVo) throws Exception {
		return userDao.userJoin(userVo);
	}

	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		return userDao.userLogin(userVo);
	}
	
}
