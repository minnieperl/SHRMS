package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.LeaveRequest;
import com.example.SHRMS.service.LeaveService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/leaves")
@RequiredArgsConstructor
public class LeaveController {

    private final LeaveService leaveService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String myLeaves(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("leaves", leaveService.getLeavesByEmployee(emp.getEmployeeId()));
        return "leave/list";
    }

    @GetMapping("/apply")
    public String applyForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("leaveRequest", new LeaveRequest());
        return "leave/apply";
    }

    @PostMapping("/apply")
    public String applyLeave(@RequestParam String leaveType,
                             @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
                             @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
                             @RequestParam String reason,
                             RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        LeaveRequest req = new LeaveRequest();
        req.setEmployee(emp);
        req.setLeaveType(leaveType);
        req.setStartDate(startDate);
        req.setEndDate(endDate);
        req.setReason(reason);
        leaveService.applyLeave(req);
        ra.addFlashAttribute("success", "Leave application submitted!");
        return "redirect:/leaves";
    }

    @GetMapping("/manage")
    public String manageLeaves(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        String role = emp.getRole().getRoleName();
        model.addAttribute("role", role);

        if ("ADMIN".equals(role) || "HR".equals(role)) {
            model.addAttribute("leaves", leaveService.getPendingLeaves());
        } else {
            model.addAttribute("leaves", leaveService.getPendingLeavesForManager(emp.getEmployeeId()));
        }
        return "leave/manage";
    }

    @PostMapping("/action/{id}")
    public String leaveAction(@PathVariable Long id,
                              @RequestParam String action,
                              RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        leaveService.updateStatus(id, action, emp);
        ra.addFlashAttribute("success", "Leave " + action.toLowerCase() + " successfully.");
        return "redirect:/leaves/manage";
    }
}
