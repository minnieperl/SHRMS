package com.example.SHRMS.repository;

import com.example.SHRMS.model.Meeting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MeetingRepository extends JpaRepository<Meeting, Long> {

    List<Meeting> findByCreatedBy_EmployeeIdOrderByScheduledAtDesc(Long employeeId);

    @Query("SELECT m FROM Meeting m JOIN m.attendees a WHERE a.employeeId = :empId ORDER BY m.scheduledAt DESC")
    List<Meeting> findByAttendeeId(@Param("empId") Long empId);

    List<Meeting> findAllByOrderByScheduledAtDesc();
}
