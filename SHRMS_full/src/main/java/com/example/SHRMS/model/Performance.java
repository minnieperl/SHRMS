package com.example.SHRMS.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "performance")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Performance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "performance_id")
    private Long performanceId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "attendance_score")
    private Integer attendanceScore;

    @Column(name = "task_score")
    private Integer taskScore;

    @Column(name = "remarks", length = 255)
    private String remarks;

    @Column(name = "period", length = 20)
    private String period; // e.g., "Q1-2024", "2024-01"
}
