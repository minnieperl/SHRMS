package com.example.SHRMS.repository;

import com.example.SHRMS.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

    List<Task> findByAssignedTo_EmployeeIdOrderByDeadlineAsc(Long employeeId);

    List<Task> findByAssignedBy_EmployeeIdOrderByDeadlineAsc(Long employeeId);

    @Query("SELECT t FROM Task t WHERE t.assignedTo.manager.employeeId = :managerId ORDER BY t.deadline ASC")
    List<Task> findByManagerId(@Param("managerId") Long managerId);

    List<Task> findByStatusOrderByDeadlineAsc(String status);

    @Query("SELECT t FROM Task t WHERE t.assignedTo.employeeId = :empId AND t.status = :status")
    List<Task> findByEmployeeAndStatus(@Param("empId") Long empId, @Param("status") String status);

    long countByAssignedTo_EmployeeIdAndStatus(Long employeeId, String status);
}
