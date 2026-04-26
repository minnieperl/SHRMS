package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.service.EmployeeService;
import com.example.SHRMS.service.PayrollService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller
@RequestMapping("/payroll")
@RequiredArgsConstructor
public class PayrollController {

    private final PayrollService payrollService;
    private final EmployeeService employeeService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String payrollList(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        String role = emp.getRole().getRoleName();
        model.addAttribute("role", role);

        if ("ADMIN".equals(role) || "HR".equals(role)) {
            model.addAttribute("payrolls", payrollService.getAllPayrolls());
        } else {
            model.addAttribute("payrolls", payrollService.getPayrollByEmployee(emp.getEmployeeId()));
        }
        return "payroll/list";
    }

    @GetMapping("/generate")
    public String generateForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("employees", employeeService.getActiveEmployees());
        return "payroll/generate";
    }

    @PostMapping("/generate")
    public String generatePayroll(@RequestParam Long employeeId,
                                  @RequestParam String salaryMonth,
                                  @RequestParam BigDecimal deductions,
                                  @RequestParam BigDecimal bonus,
                                  RedirectAttributes ra) {
        try {
            Employee target = employeeService.findById(employeeId)
                    .orElseThrow(() -> new RuntimeException("Employee not found"));
            payrollService.generatePayroll(target, salaryMonth, deductions, bonus);
            ra.addFlashAttribute("success", "Payroll generated for " + target.getFullName());
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/payroll";
    }

    @GetMapping("/slip/{id}")
    public String payslip(@PathVariable Long id, Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        payrollService.findById(id).ifPresent(p -> model.addAttribute("payroll", p));
        return "payroll/slip";
    }

    @PostMapping("/delete/{id}")
    public String deletePayroll(@PathVariable Long id, RedirectAttributes ra) {
        payrollService.deletePayroll(id);
        ra.addFlashAttribute("success", "Payroll record deleted.");
        return "redirect:/payroll";
    }
}
