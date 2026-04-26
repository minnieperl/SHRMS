package com.example.SHRMS.service;

import com.example.SHRMS.model.Meeting;
import com.example.SHRMS.model.Mom;
import com.example.SHRMS.repository.MeetingRepository;
import com.example.SHRMS.repository.MomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class MeetingService {

    private final MeetingRepository meetingRepository;
    private final MomRepository momRepository;

    public List<Meeting> getAllMeetings() {
        return meetingRepository.findAllByOrderByScheduledAtDesc();
    }

    public List<Meeting> getMeetingsByCreator(Long employeeId) {
        return meetingRepository.findByCreatedBy_EmployeeIdOrderByScheduledAtDesc(employeeId);
    }

    public List<Meeting> getMeetingsForEmployee(Long employeeId) {
        return meetingRepository.findByAttendeeId(employeeId);
    }

    public Optional<Meeting> findById(Long id) {
        return meetingRepository.findById(id);
    }

    @Transactional
    public Meeting saveMeeting(Meeting meeting) {
        return meetingRepository.save(meeting);
    }

    @Transactional
    public void deleteMeeting(Long id) {
        meetingRepository.deleteById(id);
    }

    @Transactional
    public Mom saveMom(Mom mom) {
        return momRepository.save(mom);
    }

    public Optional<Mom> getMomByMeeting(Long meetingId) {
        return momRepository.findByMeeting_MeetingId(meetingId);
    }
}
