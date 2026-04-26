package com.example.SHRMS.repository;

import com.example.SHRMS.model.LeaveRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LeaveRequestRepository extends JpaRepository<LeaveRequest, Long> {

    List<LeaveRequest> findByEmployee_EmployeeIdOrderByLeaveIdDesc(Long employeeId);

    List<LeaveRequest> findByStatusOrderByLeaveIdDesc(String status);

    @Query("SELECT l FROM LeaveRequest l WHERE l.employee.manager.employeeId = :managerId ORDER BY l.leaveId DESC")
    List<LeaveRequest> findPendingForManager(@Param("managerId") Long managerId);

    @Query("SELECT l FROM LeaveRequest l WHERE l.employee.employeeId = :empId AND l.status = :status")
    List<LeaveRequest> findByEmployeeAndStatus(@Param("empId") Long empId, @Param("status") String status);

    long countByStatus(String status);
}
