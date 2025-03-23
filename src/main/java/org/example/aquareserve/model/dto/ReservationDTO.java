package org.example.aquareserve.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;

public record ReservationDTO(
        String reservationID,
        String reservationPlace,
        String memberID,
        String timeslotID,
        String equipmentID,
        String lessonID,
        @JsonFormat(pattern = "yyyy-MM-dd")
        LocalDate reservationDate,
        BigDecimal paymentAmount,
        String paymentStatus
) {}
