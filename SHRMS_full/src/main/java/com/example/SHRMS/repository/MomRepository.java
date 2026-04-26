package com.example.SHRMS.repository;

import com.example.SHRMS.model.Mom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MomRepository extends JpaRepository<Mom, Long> {
    Optional<Mom> findByMeeting_MeetingId(Long meetingId);
    List<Mom> findAllByMeeting_MeetingId(Long meetingId);
}
