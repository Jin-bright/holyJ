package com.sh.oee.craig.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.common.OeeUtils;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigEntity;
import com.sh.oee.craig.model.service.CraigService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/craig")
@Controller
public class CraigController {

	@Autowired
	private CraigService craigService;
	
	@Autowired
	private ServletContext application;
	
	//전체 중고거래 게시물 조회 - 이렇게 하면 모델에 안담김 그냥 객체 자체를 반환해야할듯 
	// 그리고 @RestController 이거 자체가 걍 데이터를 반환해주는거같음 page 아님 
	// - 추후 멤버별 N/F에 따라서 조회하는게 달라져야되는데 ,, ㄴㅇㄱ
	/**
	@GetMapping("/craigList")
	public String craigList(Model model){
		
		List<Craig> craigList = craigService.craigList();
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		
		log.debug( "■ craigList = {}", craigList);
		log.debug( "■ craigCategory = {}", craigCategory);
		
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		
		return "forward:/craigList.jsp";
	}
	
	
	**/
	// 전체 중고거래 게시물 조회 - 추후 멤버별 N/F에 따라서 조회하는게 달라져야되는데 ,, ㄴㅇㄱ
	// 일단 no 역순
	@GetMapping("/craigList.do")
	public void craigList(@RequestParam(defaultValue = "1")int cpage, Model model){
		

		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		log.debug( "■ craigCategory = {}", craigCategory);
		
		//페이징
		int limit = 12; //한페이지당 조회할 게시글 수 
		int offset = (cpage - 1)*limit; // 현제페이지가 1 ->  첫페이지는 0 //  현재페이지가 2 -> 두번째 페이지는 10 
	
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<Craig> craigList = craigService.craigList(rowBounds);
		log.debug( "■ craigList = {}", craigList);
		
	
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		
		return;
	}
	
	//중고거래 게시물 등록 페이지로이동
	@GetMapping("/craigEnroll.do")
	public void craigEnroll(Model model ) {
		
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		log.debug( "■ craigCategory = {}", craigCategory);
		
		model.addAttribute("craigCategory", craigCategory);
		return;
	}
	
	// board insert 
	@PostMapping("/craigBoardEnroll.do")
	public String insertCraigBoard(Craig craig, @RequestParam("upFile") List<MultipartFile> upFiles, 
			  RedirectAttributes redirectAttr){
		
	
		
		String saveDirectory = application.getRealPath("/resources/upload/craig");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일저장 방법1 - 1)서버컴퓨터에저장 및 attachment 객체 만들기 
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			log.debug("upFile - = {}", upFile.getOriginalFilename());
			log.debug("upFile-size = {}", upFile.getSize());	
		
		
			if(upFile.getSize() > 0 ) {//1-1)저장 
				String renamedFilename =  OeeUtils.renameMultipartFile( upFile );
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				
				try {
					upFile.transferTo(destFile);	
				}catch(IllegalStateException | IOException e){
					log.error(e.getMessage(), e);
				}
				
				//1-2) attachment 객체생성 및  board에 추가
				CraigAttachment attach = new CraigAttachment();
				attach.setReFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				craig.addAttachment(attach);
			}
			
		}//end-for문
		
		//저장
		int result = craigService.insertCraigBoard(craig);
		log.debug( "result : " + result );

		redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 등록했습니다😊");
		
		return "redirect:/craig/craigList.do";
		
	}
	
	
	
	
	
	//지도 선택 
	@GetMapping("/craigList.do")
	public void craigPickPlace() {
		
	}

	

	
	
}
