package com.sh.oee.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.admin.model.service.AdminService;
import com.sh.oee.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	public AdminService adminService;
	
	@GetMapping("/adminList.do")
	public void adminList(Model model) {
		
		List<Member> adminList = adminService.adminList();
		log.debug("adminList = {}", adminList);
		model.addAttribute("adminList", adminList);
		
		return;
		
	}
}