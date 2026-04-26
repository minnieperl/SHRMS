package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final SessionHelper sessionHelper;
    private final EmployeeService employeeService;
    private final AttendanceService attendanceService;
    private final LeaveService leaveService;
    private final TaskService taskService;
    private final HolidayService holidayService;
    private final PayrollService payrollService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        if (emp == null) return "redirect:/login";

        String role = emp.getRole().getRoleName();
        model.addAttribute("employee", emp);
        model.addAttribute("role", role);

        // Common data
        model.addAttribute("upcomingHolidays", holidayService.getUpcomingHolidays());
        model.addAttribute("todayAttendance", attendanceService.getTodayAttendance(emp.getEmployeeId()).orElse(null));

        if ("ADMIN".equals(role) || "HR".equals(role)) {
            model.addAttribute("totalEmployees", employeeService.countActive());
            model.addAttribute("presentToday", attendanceService.countPresentToday());
            model.addAttribute("pendingLeaves", leaveService.countPending());
            model.addAttribute("allLeaves", leaveService.getPendingLeaves());
            model.addAttribute("recentPayrolls", payrollService.getAllPayrolls().stream().limit(5).toList());
        }

        if ("MANAGER".equals(role)) {
            model.addAttribute("myTeam", employeeService.getEmployeesByManager(emp.getEmployeeId()));
            model.addAttribute("pendingLeaves", leaveService.getPendingLeavesForManager(emp.getEmployeeId()).size());
            model.addAttribute("teamTasks", taskService.getTasksForManagerTeam(emp.getEmployeeId()));
        }

        // Employee-level stats
        model.addAttribute("myTasks", taskService.getTasksForEmployee(emp.getEmployeeId()));
        model.addAttribute("myLeaves", leaveService.getLeavesByEmployee(emp.getEmployeeId()).stream().limit(3).toList());
        model.addAttribute("todoCount", taskService.countByEmployeeAndStatus(emp.getEmployeeId(), "TODO"));
        model.addAttribute("inProgressCount", taskService.countByEmployeeAndStatus(emp.getEmployeeId(), "IN_PROGRESS"));
        model.addAttribute("doneCount", taskService.countByEmployeeAndStatus(emp.getEmployeeId(), "DONE"));

        LocalDate now = LocalDate.now();
        LocalDate monthStart = now.withDayOfMonth(1);
        model.addAttribute("presentDays", attendanceService.countPresentInMonth(emp.getEmployeeId(), monthStart, now));

        return "dashboard/dashboard";
    }
}
