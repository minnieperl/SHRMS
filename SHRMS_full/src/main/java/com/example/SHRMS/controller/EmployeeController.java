package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.*;
import com.example.SHRMS.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/employees")
@RequiredArgsConstructor
public class EmployeeController {

    private final EmployeeService employeeService;
    private final SessionHelper sessionHelper;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @GetMapping
    public String listEmployees(@RequestParam(required = false) String search, Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());

        if (search != null && !search.isBlank()) {
            model.addAttribute("employees", employeeService.searchEmployees(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("employees", employeeService.getAllEmployees());
        }
        return "employee/list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("newEmployee", new Employee());
        model.addAttribute("roles", employeeService.getAllRoles());
        model.addAttribute("departments", employeeService.getAllDepartments());
        model.addAttribute("managers", employeeService.getManagers());
        return "employee/add";
    }

    @PostMapping("/add")
    public String addEmployee(@ModelAttribute("newEmployee") Employee newEmployee,
                              @RequestParam(value = "photo", required = false) MultipartFile photo,
                              @RequestParam(value = "managerId", required = false) Long managerId,
                              @RequestParam("roleId") Integer roleId,
                              @RequestParam("departmentId") Integer departmentId,
                              RedirectAttributes redirectAttributes) {
        try {
            employeeService.getAllRoles().stream()
                    .filter(r -> r.getRoleId().equals(roleId)).findFirst()
                    .ifPresent(newEmployee::setRole);
            employeeService.getAllDepartments().stream()
                    .filter(d -> d.getDepartmentId().equals(departmentId)).findFirst()
                    .ifPresent(newEmployee::setDepartment);
            if (managerId != null) {
                employeeService.findById(managerId).ifPresent(newEmployee::setManager);
            }
            employeeService.saveEmployee(newEmployee, photo, uploadDir);
            redirectAttributes.addFlashAttribute("success", "Employee added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/employees";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        employeeService.findById(id).ifPresent(e -> model.addAttribute("editEmployee", e));
        model.addAttribute("roles", employeeService.getAllRoles());
        model.addAttribute("departments", employeeService.getAllDepartments());
        model.addAttribute("managers", employeeService.getManagers());
        return "employee/edit";
    }

    @PostMapping("/edit/{id}")
    public String editEmployee(@PathVariable Long id,
                               @ModelAttribute("editEmployee") Employee editEmployee,
                               @RequestParam(value = "photo", required = false) MultipartFile photo,
                               @RequestParam(value = "managerId", required = false) Long managerId,
                               @RequestParam("roleId") Integer roleId,
                               @RequestParam("departmentId") Integer departmentId,
                               RedirectAttributes redirectAttributes) {
        try {
            editEmployee.setEmployeeId(id);
            employeeService.getAllRoles().stream()
                    .filter(r -> r.getRoleId().equals(roleId)).findFirst()
                    .ifPresent(editEmployee::setRole);
            employeeService.getAllDepartments().stream()
                    .filter(d -> d.getDepartmentId().equals(departmentId)).findFirst()
                    .ifPresent(editEmployee::setDepartment);
            if (managerId != null) {
                employeeService.findById(managerId).ifPresent(editEmployee::setManager);
            }
            employeeService.saveEmployee(editEmployee, photo, uploadDir);
            redirectAttributes.addFlashAttribute("success", "Employee updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/employees";
    }

    @GetMapping("/view/{id}")
    public String viewEmployee(@PathVariable Long id, Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        employeeService.findById(id).ifPresent(e -> model.addAttribute("viewEmployee", e));
        return "employee/view";
    }

    @PostMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        employeeService.deleteEmployee(id);
        redirectAttributes.addFlashAttribute("success", "Employee deactivated successfully.");
        return "redirect:/employees";
    }
}
