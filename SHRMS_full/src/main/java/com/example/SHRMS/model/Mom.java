package com.example.SHRMS.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "mom")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Mom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mom_id")
    private Long momId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "meeting_id")
    private Meeting meeting;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
}
