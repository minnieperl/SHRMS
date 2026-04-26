package com.example.SHRMS.repository;

import com.example.SHRMS.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    Optional<Employee> findByEmail(String email);

    Optional<Employee> findByEmployeeCode(String employeeCode);

    List<Employee> findByStatus(String status);

    @Query("SELECT e FROM Employee e WHERE e.manager.employeeId = :managerId AND e.status = 'ACTIVE'")
    List<Employee> findByManagerId(@Param("managerId") Long managerId);

    @Query("SELECT e FROM Employee e WHERE e.department.departmentId = :deptId AND e.status = 'ACTIVE'")
    List<Employee> findByDepartmentId(@Param("deptId") Integer deptId);

    @Query("SELECT e FROM Employee e WHERE e.role.roleName = :roleName")
    List<Employee> findByRoleName(@Param("roleName") String roleName);

    @Query("SELECT e FROM Employee e WHERE " +
           "LOWER(e.firstName) LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(e.lastName) LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(e.email) LIKE LOWER(CONCAT('%', :q, '%')) OR " +
           "LOWER(e.employeeCode) LIKE LOWER(CONCAT('%', :q, '%'))")
    List<Employee> searchEmployees(@Param("q") String query);

    long countByStatus(String status);
}
