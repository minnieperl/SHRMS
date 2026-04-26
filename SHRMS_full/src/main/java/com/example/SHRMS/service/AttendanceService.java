package com.example.SHRMS.service;

import com.example.SHRMS.model.Attendance;
import com.example.SHRMS.model.Employee;
import com.example.SHRMS.repository.AttendanceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class AttendanceService {

    private final AttendanceRepository attendanceRepository;

    public Optional<Attendance> getTodayAttendance(Long employeeId) {
        return attendanceRepository.findByEmployee_EmployeeIdAndAttendanceDate(employeeId, LocalDate.now());
    }

    public List<Attendance> getAttendanceHistory(Long employeeId) {
        return attendanceRepository.findByEmployee_EmployeeIdOrderByAttendanceDateDesc(employeeId);
    }

    public List<Attendance> getAttendanceByDate(LocalDate date) {
        return attendanceRepository.findByAttendanceDate(date);
    }

    public List<Attendance> getAttendanceByRange(Long empId, LocalDate start, LocalDate end) {
        return attendanceRepository.findByEmployeeAndDateRange(empId, start, end);
    }

    @Transactional
    public Attendance checkIn(Employee employee, MultipartFile photo, String uploadDir) throws IOException {
        LocalDate today = LocalDate.now();
        Optional<Attendance> existing = attendanceRepository.findByEmployee_EmployeeIdAndAttendanceDate(
                employee.getEmployeeId(), today);

        Attendance attendance = existing.orElse(new Attendance());
        attendance.setEmployee(employee);
        attendance.setAttendanceDate(today);
        attendance.setCheckInTime(LocalDateTime.now());

        // Determine late status (after 9:30 AM)
        LocalDateTime checkIn = attendance.getCheckInTime();
        if (checkIn.getHour() > 9 || (checkIn.getHour() == 9 && checkIn.getMinute() > 30)) {
            attendance.setStatus("LATE");
        } else {
            attendance.setStatus("PRESENT");
        }

        if (photo != null && !photo.isEmpty()) {
            String filename = UUID.randomUUID() + "_" + photo.getOriginalFilename();
            Path uploadPath = Paths.get(uploadDir, "attendance_photos");
            Files.createDirectories(uploadPath);
            Files.copy(photo.getInputStream(), uploadPath.resolve(filename), StandardCopyOption.REPLACE_EXISTING);
            attendance.setPhotoPath("attendance_photos/" + filename);
        }

        return attendanceRepository.save(attendance);
    }

    @Transactional
    public Attendance checkOut(Long employeeId) {
        LocalDate today = LocalDate.now();
        Attendance attendance = attendanceRepository
                .findByEmployee_EmployeeIdAndAttendanceDate(employeeId, today)
                .orElseThrow(() -> new RuntimeException("No check-in found for today"));
        attendance.setCheckOutTime(LocalDateTime.now());
        return attendanceRepository.save(attendance);
    }

    public long countPresentToday() {
        return attendanceRepository.countByDate(LocalDate.now());
    }

    public long countPresentInMonth(Long empId, LocalDate start, LocalDate end) {
        return attendanceRepository.countPresentDays(empId, start, end);
    }
}
