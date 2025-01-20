package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.UsersVO;

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

	// 중복체크 ID
	public String Duplicate_check(String id) {
		int count = sqlSession.selectOne("u.Duplicate_check", id); // MyBatis 매퍼 호출
		return count > 0 ? "1" : "0"; // 중복이면 "1", 아니면 "0" 반환
	}


//로그인을 위한 ID 조회
	public UsersVO select_id(String id) {
		return sqlSession.selectOne("u.select_id", id);
	}
	
	// 이름과 이메일을 통한 ID 조회
	public String findUserId(UsersVO vo) {
	    System.out.println("DAO로 전달된 이름: " + vo.getUser_name());
	    System.out.println("DAO로 전달된 이메일: " + vo.getUser_email());
	    
	    // 쿼리 실행
	    String result = sqlSession.selectOne("u.findUserId", vo);
	    
	    // 디버깅: 쿼리 실행 결과 확인
	    if (result != null) {
	        System.out.println("쿼리 실행 결과 ID: " + result);
	    } else {
	        System.out.println("쿼리 실행 결과 없음");
	    }
	    
	    return result;
	}


	// id, 이메일을 통한 pwd 조회
	public String findUserpwd(UsersVO vo) {
	    System.out.println("DAO로 전달된 ID: " + vo.getId());
	    System.out.println("DAO로 전달된 EMAIL: " + vo.getUser_email());
	    
	    // 쿼리 실행
	    String userPwd = sqlSession.selectOne("u.findUserpwd", vo);
	    
	    System.out.println("쿼리 실행 결과: " + (userPwd != null ? userPwd : "null"));
	    return userPwd;
	}


	// 회원 정보 조회
	public UsersVO adminOne(int user_Id) {
		UsersVO vo = sqlSession.selectOne("u.user_detail", user_Id);
		return vo;
	}
	
	//회원 정보 수정
	public int updateFin(UsersVO vo) {
		int res = sqlSession.update("u.user_admin_update", vo);
		return res;
	}

	//회원 삭제
	public int adminUserDel(int user_Id) {
		int res = sqlSession.delete("u.user_admin_del", user_Id);
		return res;
	}
	
}
