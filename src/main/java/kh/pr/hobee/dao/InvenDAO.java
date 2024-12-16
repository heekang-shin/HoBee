package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kh.pr.hobee.vo.CategoryVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Mapper
@Repository
public class InvenDAO {
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<CategoryVO> selectInven(int category){
		List<CategoryVO> list = sqlSession.selectList("i.big_list", category);
		return list;
	}
	
}
