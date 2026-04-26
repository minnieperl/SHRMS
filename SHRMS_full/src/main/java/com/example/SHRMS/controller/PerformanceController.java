package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.Performance;
import com.example.SHRMS.service.EmployeeService;
import com.example.SHRMS.service.PerformanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/performance")
@RequiredArgsConstructor
public class PerformanceController {

    private final PerformanceService performanceService;
    private final EmployeeService employeeService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String list(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        String role = emp.getRole().getRoleName();
        model.addAttribute("role", role);

        if ("EMPLOYEE".equals(role)) {
            model.addAttribute("performances", performanceService.getByEmployee(emp.getEmployeeId()));
        } else {
            model.addAttribute("performances", performanceService.getAll());
        }
        return "performance/list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("performance", new Performance());
        model.addAttribute("employees", employeeService.getActiveEmployees());
        return "performance/add";
    }

    @PostMapping("/add")
    public String addPerformance(@RequestParam Long employeeId,
                                 @RequestParam Integer rating,
                                 @RequestParam Integer attendanceScore,
                                 @RequestParam Integer taskScore,
                                 @RequestParam String remarks,
                                 @RequestParam String period,
                                 RedirectAttributes ra) {
        Performance perf = new Performance();
        employeeService.findById(employeeId).ifPresent(perf::setEmployee);
        perf.setRating(rating);
        perf.setAttendanceScore(attendanceScore);
        perf.setTaskScore(taskScore);
        perf.setRemarks(remarks);
        perf.setPeriod(period);
        performanceService.save(perf);
        ra.addFlashAttribute("success", "Performance review added!");
        return "redirect:/performance";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        performanceService.delete(id);
        ra.addFlashAttribute("success", "Performance record deleted.");
        return "redirect:/performance";
    }
}
