package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.bcrypt.BCrypt;

import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;

public class MypageDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 찜목록 로그인한 사람이 찜한내역 가져오기
	public List<Integer> selectheart(int user_Id) {
		List<Integer> list = sqlSession.selectList("m.heart_list", user_Id);
		return list;
	}

	// 찜목록 로그인한 사람이 찜한내역 가져오기 --2
	public HobeeVO selectggim(int hb_idx) {
		System.out.println("dao : " + hb_idx);
		HobeeVO vo = sqlSession.selectOne("m.ggim_list", hb_idx);
		System.out.println("dao 다녀옴 : " + hb_idx);
		return vo;
	}

	// 신청내역 목록 가지고오기
	public List<Integer> select_apply(int user_Id) {
		System.out.println(user_Id);
		List<Integer> apply_list = sqlSession.selectList("m.apply_list", user_Id);
		System.out.println("kkk: " + apply_list.size());
		return apply_list;
	}

	public HobeeVO select_apply_two(int hb_idx) {
		HobeeVO vo = sqlSession.selectOne("m.finish_apply", hb_idx);
		System.out.println("신청내역dao 다녀옴 : " + hb_idx);
		return vo;
	}

	public List<ReserveVO> select_reserve_info(int reserve_id) {
	    return sqlSession.selectList("m.reserve_info", reserve_id);
	}
	

	//신청내역에서 카테고리네임 불러오기
	public String select_category_name(int category_num) {
		String cate = sqlSession.selectOne("m.category_select",category_num);
		return cate;
	}
	
	
	// 신청내역 삭제
	public int apply_delete(int reserve_id) {
		int res = sqlSession.delete("m.apply_delete", reserve_id);
		return res;
	}

	// user_id를 통한 유저 한명 조회 유저정보 수정을 위한 검색
	public UsersVO userupdate(int user_Id) {
		UsersVO vo = sqlSession.selectOne("m.user_update_view", user_Id);
		return vo;
	}

	// 유저정보수정
	public int updateFin(UsersVO vo) {
		System.out.println("dao");
		int res = sqlSession.update("m.user_update", vo);
		return res;

	}

	// 유저 삭제를 위한 한명 조회
	public UsersVO userdelete(int user_Id) {
		UsersVO vo = sqlSession.selectOne("m.user_delete_view", user_Id);
		return vo;
	}

	// 유저삭제
	public int mypage_user_delete(UsersVO vo) {
		System.out.println("dao");
		int res = sqlSession.delete("m.user_delete_finish", vo);
		return res;
	}

}
