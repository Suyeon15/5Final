package kh.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.spring.dto.ScheduleDTO;
import kh.spring.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	public ScheduleService ss;
	
	@RequestMapping("scheduleOpen")
	public String scheduleOpen() throws Exception {
		return "/member/schedulePopup";
	}
	
	@RequestMapping("addSchedule")
	public String addSchedule(ScheduleDTO dto) throws Exception {
		
		ss.addSchedule(dto);
		return "/member/success";
	}
	
}
