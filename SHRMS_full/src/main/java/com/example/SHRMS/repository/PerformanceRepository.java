package com.example.SHRMS.repository;

import com.example.SHRMS.model.Performance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PerformanceRepository extends JpaRepository<Performance, Long> {
    List<Performance> findByEmployee_EmployeeIdOrderByPeriodDesc(Long employeeId);
    Optional<Performance> findByEmployee_EmployeeIdAndPeriod(Long employeeId, String period);
    List<Performance> findByPeriodOrderByRatingDesc(String period);
}
