package com.example.SHRMS.controller;

import com.example.SHRMS.config.SessionHelper;
import com.example.SHRMS.model.*;
import com.example.SHRMS.service.EmployeeService;
import com.example.SHRMS.service.MeetingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/meetings")
@RequiredArgsConstructor
public class MeetingController {

    private final MeetingService meetingService;
    private final EmployeeService employeeService;
    private final SessionHelper sessionHelper;

    @GetMapping
    public String listMeetings(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        String role = emp.getRole().getRoleName();
        model.addAttribute("role", role);

        if ("ADMIN".equals(role) || "HR".equals(role)) {
            model.addAttribute("meetings", meetingService.getAllMeetings());
        } else {
            model.addAttribute("meetings", meetingService.getMeetingsForEmployee(emp.getEmployeeId()));
        }
        return "meeting/list";
    }

    @GetMapping("/schedule")
    public String scheduleForm(Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        model.addAttribute("employees", employeeService.getActiveEmployees());
        return "meeting/schedule";
    }

    @PostMapping("/schedule")
    public String scheduleMeeting(@RequestParam String title,
                                  @RequestParam String scheduledAt,
                                  @RequestParam List<Long> attendeeIds,
                                  RedirectAttributes ra) {
        Employee emp = sessionHelper.getCurrentEmployee();
        Meeting meeting = new Meeting();
        meeting.setTitle(title);
        meeting.setCreatedBy(emp);
        meeting.setScheduledAt(LocalDateTime.parse(scheduledAt,
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));

        List<Employee> attendees = attendeeIds.stream()
                .map(id -> employeeService.findById(id).orElse(null))
                .filter(e -> e != null).toList();
        meeting.setAttendees(attendees);
        meetingService.saveMeeting(meeting);
        ra.addFlashAttribute("success", "Meeting scheduled successfully!");
        return "redirect:/meetings";
    }

    @GetMapping("/view/{id}")
    public String viewMeeting(@PathVariable Long id, Model model) {
        Employee emp = sessionHelper.getCurrentEmployee();
        model.addAttribute("employee", emp);
        model.addAttribute("role", emp.getRole().getRoleName());
        meetingService.findById(id).ifPresent(m -> model.addAttribute("meeting", m));
        meetingService.getMomByMeeting(id).ifPresent(mom -> model.addAttribute("mom", mom));
        return "meeting/view";
    }

    @PostMapping("/mom/{meetingId}")
    public String addMom(@PathVariable Long meetingId,
                         @RequestParam String notes,
                         RedirectAttributes ra) {
        meetingService.findById(meetingId).ifPresent(meeting -> {
            Mom mom = meetingService.getMomByMeeting(meetingId).orElse(new Mom());
            mom.setMeeting(meeting);
            mom.setNotes(notes);
            meetingService.saveMom(mom);
        });
        ra.addFlashAttribute("success", "MOM saved successfully!");
        return "redirect:/meetings/view/" + meetingId;
    }

    @PostMapping("/delete/{id}")
    public String deleteMeeting(@PathVariable Long id, RedirectAttributes ra) {
        meetingService.deleteMeeting(id);
        ra.addFlashAttribute("success", "Meeting deleted.");
        return "redirect:/meetings";
    }
}
