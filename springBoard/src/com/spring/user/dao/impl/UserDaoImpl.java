package com.spring.user.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int idCheck(UserVo userVo) throws Exception{
		return sqlSession.selectOne("user.idCheck", userVo);
	}

	@Override
	public List<ComCodeVo> phoneList() throws Exception {
		return sqlSession.selectList("user.phoneList");
	}

	@Override
	public int userJoin(UserVo userVo) throws Exception {
		return sqlSession.insert("user.userJoin", userVo);
	}

	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		return sqlSession.selectOne("user.userLogin", userVo);
	}
	
}
