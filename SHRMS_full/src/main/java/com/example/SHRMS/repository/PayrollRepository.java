package com.example.SHRMS.repository;

import com.example.SHRMS.model.Payroll;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PayrollRepository extends JpaRepository<Payroll, Long> {
    List<Payroll> findByEmployee_EmployeeIdOrderBySalaryMonthDesc(Long employeeId);
    Optional<Payroll> findByEmployee_EmployeeIdAndSalaryMonth(Long employeeId, String salaryMonth);
    List<Payroll> findBySalaryMonthOrderByEmployee_FirstNameAsc(String salaryMonth);
    List<String> findDistinctSalaryMonthBy();
}
