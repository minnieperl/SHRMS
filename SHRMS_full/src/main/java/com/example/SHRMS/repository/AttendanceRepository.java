package com.example.SHRMS.repository;

import com.example.SHRMS.model.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    Optional<Attendance> findByEmployee_EmployeeIdAndAttendanceDate(Long employeeId, LocalDate date);

    List<Attendance> findByEmployee_EmployeeIdOrderByAttendanceDateDesc(Long employeeId);

    @Query("SELECT a FROM Attendance a WHERE a.attendanceDate = :date ORDER BY a.employee.firstName")
    List<Attendance> findByAttendanceDate(@Param("date") LocalDate date);

    @Query("SELECT a FROM Attendance a WHERE a.employee.employeeId = :empId " +
           "AND a.attendanceDate BETWEEN :start AND :end ORDER BY a.attendanceDate DESC")
    List<Attendance> findByEmployeeAndDateRange(@Param("empId") Long empId,
                                                @Param("start") LocalDate start,
                                                @Param("end") LocalDate end);

    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.employee.employeeId = :empId AND a.status = 'PRESENT'" +
           " AND a.attendanceDate BETWEEN :start AND :end")
    long countPresentDays(@Param("empId") Long empId, @Param("start") LocalDate start, @Param("end") LocalDate end);

    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.attendanceDate = :date")
    long countByDate(@Param("date") LocalDate date);
}
