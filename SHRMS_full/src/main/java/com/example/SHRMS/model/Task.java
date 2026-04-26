package com.example.SHRMS.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Entity
@Table(name = "task")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Task {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "task_id")
    private Long taskId;

    @Column(name = "title", length = 100)
    private String title;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "assigned_to")
    private Employee assignedTo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "assigned_by")
    private Employee assignedBy;

    @Column(name = "priority", length = 20)
    private String priority; // LOW, MEDIUM, HIGH

    @Column(name = "deadline")
    private LocalDate deadline;

    @Column(name = "status", length = 20)
    private String status; // TODO, IN_PROGRESS, DONE
}
