package com.sh.oee.local.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;
import com.sh.oee.local.model.dto.LocalComment;
import com.sh.oee.local.model.dto.LocalEntity;
import com.sh.oee.member.model.dto.Member;


@Mapper
public interface LocalDao {

	//동네생활 전체목록
	List<Local> selectLocalListByDongName(List<String> myDongList);
	
	//카테고리
	@Select("select * from local_category")
	List<Map<String, String>> localCategoryList();

	//게시판 글등록
	int insertLocalBoard(Local local);
	
	int insertLocalAttachment(LocalAttachment attach);

	// ----------------------------- 하나 시작 -----------------------------------------------
	@Select("select * from local where writer = #{memberId}")
	List<Local> selectLocalList(Member member);
	
	List<LocalComment> selectLocalCommentList(String memberId);
	// ----------------------------- 하나 끝 -----------------------------------------------

	//게시글 한건 조회
	Local selectLocalOne(int no);

	//게시글 삭제
	@Delete("delete from local where no = #{no}")
	int deleteLocal(int no);
	
	//게시글 수정 첨부파일
	List<LocalAttachment> selectLocalAttachments(int no);
	
	//게시글 수정
	int updateLocalBoard(Local local);

	//조회수 증가
	int hits(int no);

	//좋아요
	List<Map<String, Object>> likecheck();



}
