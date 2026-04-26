package com.example.SHRMS.service;

import com.example.SHRMS.model.Holiday;
import com.example.SHRMS.repository.HolidayRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class HolidayService {

    private final HolidayRepository holidayRepository;

    public List<Holiday> getAllHolidays() {
        return holidayRepository.findAllByOrderByHolidayDateAsc();
    }

    public List<Holiday> getUpcomingHolidays() {
        LocalDate today = LocalDate.now();
        return holidayRepository.findByHolidayDateBetweenOrderByHolidayDateAsc(
                today, today.plusMonths(3));
    }

    public Optional<Holiday> findById(Long id) {
        return holidayRepository.findById(id);
    }

    @Transactional
    public Holiday save(Holiday holiday) {
        return holidayRepository.save(holiday);
    }

    @Transactional
    public void delete(Long id) {
        holidayRepository.deleteById(id);
    }
}
