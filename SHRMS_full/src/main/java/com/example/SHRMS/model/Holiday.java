package com.example.SHRMS.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Entity
@Table(name = "holiday")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Holiday {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "holiday_id")
    private Long holidayId;

    @Column(name = "holiday_date", unique = true)
    private LocalDate holidayDate;

    @Column(name = "holiday_name", length = 100)
    private String holidayName;

    @Column(name = "holiday_type", length = 20)
    private String holidayType; // NATIONAL, OPTIONAL, RESTRICTED
}
