package com.example.SHRMS.service;

import com.example.SHRMS.model.Performance;
import com.example.SHRMS.repository.PerformanceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PerformanceService {

    private final PerformanceRepository performanceRepository;

    public List<Performance> getByEmployee(Long empId) {
        return performanceRepository.findByEmployee_EmployeeIdOrderByPeriodDesc(empId);
    }

    public List<Performance> getByPeriod(String period) {
        return performanceRepository.findByPeriodOrderByRatingDesc(period);
    }

    public List<Performance> getAll() {
        return performanceRepository.findAll();
    }

    public Optional<Performance> findById(Long id) {
        return performanceRepository.findById(id);
    }

    @Transactional
    public Performance save(Performance performance) {
        return performanceRepository.save(performance);
    }

    @Transactional
    public void delete(Long id) {
        performanceRepository.deleteById(id);
    }
}
