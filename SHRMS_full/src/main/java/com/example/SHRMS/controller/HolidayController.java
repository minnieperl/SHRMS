package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.Holiday;
import com.example.SHRMS.service.HolidayService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/holidays")
@RequiredArgsConstructor
public class HolidayController {

    private final HolidayService holidayService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String list(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("holidays", holidayService.getAllHolidays());
        return "holiday/list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("holiday", new Holiday());
        return "holiday/add";
    }

    @PostMapping("/add")
    public String addHoliday(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate holidayDate,
                             @RequestParam String holidayName,
                             @RequestParam String holidayType,
                             RedirectAttributes ra) {
        Holiday holiday = new Holiday();
        holiday.setHolidayDate(holidayDate);
        holiday.setHolidayName(holidayName);
        holiday.setHolidayType(holidayType);
        holidayService.save(holiday);
        ra.addFlashAttribute("success", "Holiday added successfully!");
        return "redirect:/holidays";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        holidayService.delete(id);
        ra.addFlashAttribute("success", "Holiday deleted.");
        return "redirect:/holidays";
    }
}
