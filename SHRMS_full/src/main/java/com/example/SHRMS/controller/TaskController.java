package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.Task;
import com.example.SHRMS.service.EmployeeService;
import com.example.SHRMS.service.TaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/tasks")
@RequiredArgsConstructor
public class TaskController {

    private final TaskService taskService;
    private final EmployeeService employeeService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String myTasks(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        String role = emp.getRole().getRoleName();
        model.addAttribute("role", role);

        if ("ADMIN".equals(role) || "HR".equals(role)) {
            model.addAttribute("tasks", taskService.getAllTasks());
        } else if ("MANAGER".equals(role)) {
            model.addAttribute("tasks", taskService.getTasksForManagerTeam(emp.getEmployeeId()));
        } else {
            model.addAttribute("tasks", taskService.getTasksForEmployee(emp.getEmployeeId()));
        }
        return "task/list";
    }

    @GetMapping("/assign")
    public String assignForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("task", new Task());

        String role = emp.getRole().getRoleName();
        if ("MANAGER".equals(role)) {
            model.addAttribute("employees", employeeService.getEmployeesByManager(emp.getEmployeeId()));
        } else {
            model.addAttribute("employees", employeeService.getActiveEmployees());
        }
        return "task/assign";
    }

    @PostMapping("/assign")
    public String assignTask(@RequestParam String title,
                             @RequestParam String description,
                             @RequestParam Long assignedTo,
                             @RequestParam String priority,
                             @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate deadline,
                             RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setPriority(priority);
        task.setDeadline(deadline);
        task.setAssignedBy(emp);
        employeeService.findById(assignedTo).ifPresent(task::setAssignedTo);
        taskService.saveTask(task);
        ra.addFlashAttribute("success", "Task assigned successfully!");
        return "redirect:/tasks";
    }

    @PostMapping("/status/{id}")
    public String updateStatus(@PathVariable Long id,
                               @RequestParam String status,
                               RedirectAttributes ra) {
        taskService.updateStatus(id, status);
        ra.addFlashAttribute("success", "Task status updated.");
        return "redirect:/tasks";
    }

    @PostMapping("/delete/{id}")
    public String deleteTask(@PathVariable Long id, RedirectAttributes ra) {
        taskService.deleteTask(id);
        ra.addFlashAttribute("success", "Task deleted.");
        return "redirect:/tasks";
    }
}
