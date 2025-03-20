package org.example.aquareserve.model.dto;

import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ReservationDTO(
        String reservationID,
        String memberID,
        String timeslotID,
        String equipmentID,
        String lessonID,
        LocalDateTime reservationDate,
        BigDecimal paymentAmount,
        String paymentStatus
) {}
