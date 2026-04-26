package com.example.SHRMS.service;

import com.example.SHRMS.model.Employee;
import com.example.SHRMS.model.LeaveRequest;
import com.example.SHRMS.repository.LeaveRequestRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class LeaveService {

    private final LeaveRequestRepository leaveRequestRepository;

    public List<LeaveRequest> getLeavesByEmployee(Long employeeId) {
        return leaveRequestRepository.findByEmployee_EmployeeIdOrderByLeaveIdDesc(employeeId);
    }

    public List<LeaveRequest> getPendingLeaves() {
        return leaveRequestRepository.findByStatusOrderByLeaveIdDesc("PENDING");
    }

    public List<LeaveRequest> getPendingLeavesForManager(Long managerId) {
        return leaveRequestRepository.findPendingForManager(managerId);
    }

    public List<LeaveRequest> getAllLeaves() {
        return leaveRequestRepository.findAll();
    }

    public Optional<LeaveRequest> findById(Long id) {
        return leaveRequestRepository.findById(id);
    }

    @Transactional
    public LeaveRequest applyLeave(LeaveRequest leaveRequest) {
        leaveRequest.setStatus("PENDING");
        return leaveRequestRepository.save(leaveRequest);
    }

    @Transactional
    public LeaveRequest updateStatus(Long leaveId, String status, Employee approver) {
        LeaveRequest leave = leaveRequestRepository.findById(leaveId)
                .orElseThrow(() -> new RuntimeException("Leave not found"));
        leave.setStatus(status);
        leave.setApprovedBy(approver);
        return leaveRequestRepository.save(leave);
    }

    public long countPending() {
        return leaveRequestRepository.countByStatus("PENDING");
    }
}
