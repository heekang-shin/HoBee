package kh.pr.hobee.dao;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HostVO;

public class HostDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int hostadd(HostVO vo) {
		int res = sqlSession.insert("hos.host_insert", vo);
		return res;
	}
	
	public HostVO selectHost(int user_id) {
		HostVO vo = sqlSession.selectOne("hos.host_info", user_id);
		return vo;
	}
	
	public int modify(HostVO vo) {
		int res = sqlSession.update("hos.host_modify", vo);
		return res;
	}
}
