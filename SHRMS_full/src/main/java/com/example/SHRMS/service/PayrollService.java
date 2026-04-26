package com.example.SHRMS.service;

import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.Payroll;
import com.example.SHRMS.repository.PayrollRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class PayrollService {

    private final PayrollRepository payrollRepository;

    public List<Payroll> getPayrollByEmployee(Long employeeId) {
        return payrollRepository.findByEmployee_EmployeeIdOrderBySalaryMonthDesc(employeeId);
    }

    public List<Payroll> getPayrollByMonth(String month) {
        return payrollRepository.findBySalaryMonthOrderByEmployee_FirstNameAsc(month);
    }

    public List<Payroll> getAllPayrolls() {
        return payrollRepository.findAll();
    }

    public Optional<Payroll> findById(Long id) {
        return payrollRepository.findById(id);
    }

    public Optional<Payroll> findByEmployeeAndMonth(Long empId, String month) {
        return payrollRepository.findByEmployee_EmployeeIdAndSalaryMonth(empId, month);
    }

    @Transactional
    public Payroll generatePayroll(Employee employee, String salaryMonth,
                                   BigDecimal deductions, BigDecimal bonus) {
        Optional<Payroll> existing = payrollRepository
                .findByEmployee_EmployeeIdAndSalaryMonth(employee.getEmployeeId(), salaryMonth);

        Payroll payroll = existing.orElse(new Payroll());
        payroll.setEmployee(employee);
        payroll.setSalaryMonth(salaryMonth);
        payroll.setBaseSalary(employee.getBaseSalary());
        payroll.setDeductions(deductions != null ? deductions : BigDecimal.ZERO);
        payroll.setBonus(bonus != null ? bonus : BigDecimal.ZERO);

        BigDecimal net = employee.getBaseSalary()
                .subtract(payroll.getDeductions())
                .add(payroll.getBonus());
        payroll.setNetSalary(net.max(BigDecimal.ZERO));

        return payrollRepository.save(payroll);
    }

    @Transactional
    public void deletePayroll(Long id) {
        payrollRepository.deleteById(id);
    }
}
