package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HobeeVO;
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

	// 한개 찾기
	public HostVO selectHostOne(int hbidx) {
		HostVO vo = sqlSession.selectOne("hos.host_info_one", hbidx);
		return vo;
	}

	// 호스트 리스트 조회
	public List<HostVO> selectHostList() {
		List<HostVO> host_list = sqlSession.selectList("hos.admin_host_list");
		return host_list;
	}

	// 한개 찾기
	public HostVO selectHostInfo(int user_id) {
		HostVO vo = sqlSession.selectOne("hos.host_info_one", user_id);
		return vo;
	}

	//호스트 삭제
	public int hostDel(int user_id) {
		int res = sqlSession.delete("hos.host_del", user_id);
		return res;
	}
	
	// host 승인
	public int hostPost(HostVO vo) {
		System.out.println("게시상태:"+ vo.getApproval());
		int res = sqlSession.update("hos.hobee_approval", vo);
		return res;
	}
	

}
