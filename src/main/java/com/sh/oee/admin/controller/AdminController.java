package com.sh.oee.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.admin.model.service.AdminService;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	public AdminService adminService;
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(Model model) {
		List<Member> adminMemberList = adminService.selectAdminMemberList();
		log.debug("adminMemberList = ()", adminMemberList);
		model.addAttribute("adminMemberList", adminMemberList);
	}
	
	@GetMapping("/adminBoardReport.do")
	public void adminBoardReport(Model model) {
		List<BoardReport> adminBoardReport = adminService.selectAdminBoardReport();
		log.debug("adminBoardReport = ()", adminBoardReport);
		model.addAttribute("adminBoardReport", adminBoardReport);
	}
	
	@GetMapping("/adminUserReport.do")
	public void adminUserReport(Model model) {
		List<UserReport> adminUserReport = adminService.selectAdminUserReport();
		log.debug("adminUserReport = ()", adminUserReport);
		model.addAttribute("adminUserReport", adminUserReport);
	}
}
