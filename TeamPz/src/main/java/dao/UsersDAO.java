package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.UsersVO;

public class UsersDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 전체 조회
	public List<UsersVO> selectList() {
		List<UsersVO> list = sqlSession.selectList("u.user_list");
		return list;
	}

	// 아이디 생성
	public int Create(UsersVO vo) {
		int res = sqlSession.insert("u.user_insert", vo);
		return res;

	}

	// 중복체크
	public String Duplicate_check(String id) {
		int count = sqlSession.selectOne("u.Duplicate_check", id); // MyBatis 매퍼 호출
		return count > 0 ? "1" : "0"; // 중복이면 "1", 아니면 "0" 반환
	}

//로그인을 위한 ID 조회
	public UsersVO select_id(String id) {
		return sqlSession.selectOne("u.select_id", id);
	}

}
