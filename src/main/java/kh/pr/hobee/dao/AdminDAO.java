package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HostVO;
import kh.pr.hobee.vo.UsersVO;

public class AdminDAO {

	SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
    

    
    // approval = 0인 호스트 목록 조회
    public List<HostVO> ad_host_select() {
        return sqlSession.selectList("admin.ad_host_select");
    }

    // 유저 정보 조회 (user_id로 조회)
    public UsersVO ad_user_select_by_id(int user_Id) {
        return sqlSession.selectOne("admin.ad_user_select_by_id", user_Id);
    }
    
    //호스트 한명 조회
    public HostVO adHostOne(int user_id) {
    	return sqlSession.selectOne("admin.adHostOne",user_id);
    }
     
    //호스트 승인시 approval =1로 바꾸기 
    public int ad_hostapply_yes(HostVO vo) {
    	int res = sqlSession.update("admin.ad_hostapply_yes",vo);
    			return res;
    }
    
    //UsersVO불러오기->users에 '호스트'lv을 주기 위해서
    public int ad_hostapply_user(int user_id) {
    	int ress= sqlSession.update("admin.ad_hostapply_user",user_id);
    	return ress;
    }
    
  //호스트의 신청을 거절하기 =HOST테이블에서 해당 호스트 삭제 
    public int ad_host_refuse(HostVO vo) {
    	int res = sqlSession.delete("admin.ad_host_refuse",vo);
    			return res;
    }
    
    

    // 호스트 이름으로 검색
    public List<HostVO> searchHostByHostName(String searchText) {
        return sqlSession.selectList("admin.searchHostByHostName", searchText);
    }

    // 사용자 ID로 검색
    public List<HostVO> searchHostByUserId(String searchText) {
        return sqlSession.selectList("admin.searchHostByUserId", searchText);
    }

    // 전체 검색
    public List<HostVO> searchHostByAll(String searchText) {
        return sqlSession.selectList("admin.searchHostByAll", searchText);
    }
    
    
    
    
    
}
