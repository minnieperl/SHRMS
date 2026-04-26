package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.service.AttendanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/attendance")
@RequiredArgsConstructor
public class AttendanceController {

    private final AttendanceService attendanceService;
    private final SessionHelper sessionHelper;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @GetMapping
    public String attendancePage(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("todayAttendance", attendanceService.getTodayAttendance(emp.getEmployeeId()).orElse(null));
        model.addAttribute("history", attendanceService.getAttendanceHistory(emp.getEmployeeId()).stream().limit(30).toList());
        return "attendance/mark";
    }

    @PostMapping("/checkin")
    public String checkIn(@RequestParam(value = "photo", required = false) MultipartFile photo,
                          RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        try {
            attendanceService.checkIn(emp, photo, uploadDir);
            ra.addFlashAttribute("success", "Checked in successfully!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/attendance";
    }

    @PostMapping("/checkout")
    public String checkOut(RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        try {
            attendanceService.checkOut(emp.getEmployeeId());
            ra.addFlashAttribute("success", "Checked out successfully!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/attendance";
    }

    @GetMapping("/history")
    public String history(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
                          @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
                          Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        if (from != null && to != null) {
            model.addAttribute("history", attendanceService.getAttendanceByRange(emp.getEmployeeId(), from, to));
        } else {
            model.addAttribute("history", attendanceService.getAttendanceHistory(emp.getEmployeeId()));
        }
        return "attendance/history";
    }

    @GetMapping("/all")
    public String allAttendance(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
                                Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        LocalDate target = (date != null) ? date : LocalDate.now();
        model.addAttribute("attendanceList", attendanceService.getAttendanceByDate(target));
        model.addAttribute("date", target);
        return "attendance/all";
    }
}
