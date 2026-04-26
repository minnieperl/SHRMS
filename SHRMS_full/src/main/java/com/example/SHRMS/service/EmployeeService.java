package com.example.SHRMS.service;

import com.example.SHRMS.model.*;
import com.example.SHRMS.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmployeeService {

    private final EmployeeRepository employeeRepository;
    private final RoleRepository roleRepository;
    private final DepartmentRepository departmentRepository;
    private final PasswordEncoder passwordEncoder;

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    public List<Employee> getActiveEmployees() {
        return employeeRepository.findByStatus("ACTIVE");
    }

    public Optional<Employee> findById(Long id) {
        return employeeRepository.findById(id);
    }

    public Optional<Employee> findByEmail(String email) {
        return employeeRepository.findByEmail(email);
    }

    public List<Employee> searchEmployees(String query) {
        return employeeRepository.searchEmployees(query);
    }

    public List<Employee> getEmployeesByManager(Long managerId) {
        return employeeRepository.findByManagerId(managerId);
    }

    public List<Employee> getManagers() {
        List<Employee> managers = employeeRepository.findByRoleName("MANAGER");
        managers.addAll(employeeRepository.findByRoleName("HR"));
        managers.addAll(employeeRepository.findByRoleName("ADMIN"));
        return managers;
    }

    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    @Transactional
    public Employee saveEmployee(Employee employee, MultipartFile photo, String uploadDir) throws IOException {
        if (employee.getEmployeeId() == null) {
            // New employee - generate code
            String code = generateEmployeeCode();
            employee.setEmployeeCode(code);
            // Encode password
            if (employee.getPassword() != null && !employee.getPassword().isEmpty()) {
                employee.setPassword(passwordEncoder.encode(employee.getPassword()));
            } else {
                // Default password = employee code
                employee.setPassword(passwordEncoder.encode(code));
            }
        } else {
            // Update - keep old password if not changed
            Employee existing = employeeRepository.findById(employee.getEmployeeId()).orElseThrow();
            if (employee.getPassword() == null || employee.getPassword().isBlank()) {
                employee.setPassword(existing.getPassword());
            } else {
                employee.setPassword(passwordEncoder.encode(employee.getPassword()));
            }
            employee.setEmployeeCode(existing.getEmployeeCode());
            employee.setCreatedAt(existing.getCreatedAt());
        }

        // Handle photo upload
        if (photo != null && !photo.isEmpty()) {
            String filename = UUID.randomUUID() + "_" + photo.getOriginalFilename();
            Path uploadPath = Paths.get(uploadDir, "employee_photos");
            Files.createDirectories(uploadPath);
            Files.copy(photo.getInputStream(), uploadPath.resolve(filename), StandardCopyOption.REPLACE_EXISTING);
            employee.setPhotoPath("employee_photos/" + filename);
        }

        return employeeRepository.save(employee);
    }

    @Transactional
    public void deleteEmployee(Long id) {
        employeeRepository.findById(id).ifPresent(e -> {
            e.setStatus("INACTIVE");
            employeeRepository.save(e);
        });
    }

    public long countActive() {
        return employeeRepository.countByStatus("ACTIVE");
    }

    private String generateEmployeeCode() {
        long count = employeeRepository.count() + 1;
        return String.format("EMP%04d", count);
    }
}
